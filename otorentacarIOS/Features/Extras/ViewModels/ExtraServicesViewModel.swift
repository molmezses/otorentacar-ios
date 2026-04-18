//
//  ExtraServicesViewModel.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 8.04.2026.
//


import Foundation
import Combine

@MainActor
final class ExtraServicesViewModel: ObservableObject {
    @Published var services: [ExtraService] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var childrenAges: [String]

    let draft: ReservationDraft
    private let extraServicesService: ExtraServicesServiceProtocol
    
    private var childSeatExtraId: Int? {
        services.first(where: { $0.title.lowercased().contains("bebek koltuğu") })?.id
    }

    var childSeatQuantity: Int {
        guard let childSeatExtraId else { return 0 }
        return services.first(where: { $0.id == childSeatExtraId })?.quantity ?? 0
    }

    var shouldShowChildrenAges: Bool {
        childSeatQuantity > 0
    }

    private func syncChildrenAgesWithQuantity() {
        let count = childSeatQuantity

        if childrenAges.count < count {
            childrenAges.append(contentsOf: Array(repeating: "", count: count - childrenAges.count))
        } else if childrenAges.count > count {
            childrenAges = Array(childrenAges.prefix(count))
        }
    }

    func updateChildAge(_ value: String, at index: Int) {
        guard childrenAges.indices.contains(index) else { return }
        childrenAges[index] = value
    }

    init(
        draft: ReservationDraft,
        extraServicesService: ExtraServicesServiceProtocol
        
    ) {
        self.draft = draft
        self.extraServicesService = extraServicesService
        self.childrenAges = draft.childrenAges
    }

    convenience init(draft: ReservationDraft) {
        self.init(
            draft: draft,
            extraServicesService: ExtraServicesAPIService()
        )
    }

    var vehicle: Vehicle? {
        draft.selectedVehicle
    }

    var selectedExtras: [ExtraService] {
        services.filter { $0.isSelected || $0.quantity > 0 }
    }

    func onAppear() {
        Task {
            await loadExtras()
        }
    }

    func loadExtras() async {
        isLoading = true
        errorMessage = nil

        do {
            let result = try await extraServicesService.fetchExtraServices()
            services = result.map { $0.toDomain() }
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }

    func updateToggle(for serviceId: Int, isOn: Bool) {
        guard let index = services.firstIndex(where: { $0.id == serviceId }) else { return }
        services[index].isSelected = isOn

        if !isOn {
            services[index].quantity = 0
        } else if services[index].quantity == 0 {
            services[index].quantity = 1
        }
        
        syncChildrenAgesWithQuantity()
    }

    func increaseQuantity(for serviceId: Int) {
        guard let index = services.firstIndex(where: { $0.id == serviceId }) else { return }
        
        let current = services[index].quantity
        let maxCount = services[index].maxCount
        
        guard current < maxCount else { return }
        
        services[index].quantity += 1
        services[index].isSelected = true
        syncChildrenAgesWithQuantity()
    }

    func decreaseQuantity(for serviceId: Int) {
        guard let index = services.firstIndex(where: { $0.id == serviceId }) else { return }
        services[index].quantity = max(0, services[index].quantity - 1)
        services[index].isSelected = services[index].quantity > 0
        syncChildrenAgesWithQuantity()
    }

    func buildDraftForReservationDetail() -> ReservationDraft {
        ReservationDraft(
            pickUpLocation: draft.pickUpLocation,
            dropOffLocation: draft.dropOffLocation,
            pickUpDate: draft.pickUpDate,
            pickUpTime: draft.pickUpTime,
            dropOffDate: draft.dropOffDate,
            dropOffTime: draft.dropOffTime,
            selectedVehicle: draft.selectedVehicle,
            selectedVehicleModelId: draft.selectedVehicleModelId,
            currencyId: draft.currencyId,
            currencyCode: draft.currencyCode,
            selectedExtras: selectedExtras,
            customerInfo: draft.customerInfo,
            childrenAges: childrenAges
        )
    }
    
    var areChildrenAgesValid: Bool {
        guard shouldShowChildrenAges else { return true }
        return childrenAges.count == childSeatQuantity &&
               childrenAges.allSatisfy {
                   let trimmed = $0.trimmingCharacters(in: .whitespacesAndNewlines)
                   return !trimmed.isEmpty && Int(trimmed) != nil
               }
    }
}
