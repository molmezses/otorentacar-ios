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

    let draft: ReservationDraft
    private let extraServicesService: ExtraServicesServiceProtocol

    init(
        draft: ReservationDraft,
        extraServicesService: ExtraServicesServiceProtocol
    ) {
        self.draft = draft
        self.extraServicesService = extraServicesService
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
    }

    func increaseQuantity(for serviceId: Int) {
        guard let index = services.firstIndex(where: { $0.id == serviceId }) else { return }
        services[index].quantity += 1
        services[index].isSelected = true
    }

    func decreaseQuantity(for serviceId: Int) {
        guard let index = services.firstIndex(where: { $0.id == serviceId }) else { return }
        services[index].quantity = max(0, services[index].quantity - 1)
        services[index].isSelected = services[index].quantity > 0
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
            customerInfo: draft.customerInfo
        )
    }
}
