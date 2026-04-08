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
    @Published var extraServices: [ExtraService] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    let vehicle: Vehicle
    let searchRequest: ReservationSearchRequest
    
    private let service: ExtraServiceProtocol
    
    init(
        vehicle: Vehicle,
        searchRequest: ReservationSearchRequest,
        service: ExtraServiceProtocol
    ) {
        self.vehicle = vehicle
        self.searchRequest = searchRequest
        self.service = service
    }
    
    convenience init(vehicle: Vehicle, searchRequest: ReservationSearchRequest) {
        self.init(
            vehicle: vehicle,
            searchRequest: searchRequest,
            service: MockExtraService()
        )
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
            extraServices = try await service.fetchExtraServices(for: vehicle)
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    func toggleSelection(for item: ExtraService) {
        guard let index = extraServices.firstIndex(where: { $0.id == item.id }) else { return }
        
        switch extraServices[index].type {
        case .toggle, .single:
            extraServices[index].isSelected.toggle()
            if extraServices[index].isSelected && extraServices[index].quantity == 0 {
                extraServices[index].quantity = 1
            }
            if !extraServices[index].isSelected && extraServices[index].type != .quantity {
                extraServices[index].quantity = 1
            }
        case .quantity:
            if extraServices[index].quantity == 0 {
                extraServices[index].quantity = 1
                extraServices[index].isSelected = true
            } else {
                extraServices[index].quantity = 0
                extraServices[index].isSelected = false
            }
        }
    }
    
    func increaseQuantity(for item: ExtraService) {
        guard let index = extraServices.firstIndex(where: { $0.id == item.id }) else { return }
        
        extraServices[index].quantity += 1
        extraServices[index].isSelected = extraServices[index].quantity > 0
    }
    
    func decreaseQuantity(for item: ExtraService) {
        guard let index = extraServices.firstIndex(where: { $0.id == item.id }) else { return }
        
        if extraServices[index].quantity > 0 {
            extraServices[index].quantity -= 1
        }
        
        extraServices[index].isSelected = extraServices[index].quantity > 0
    }
    
    var dayCount: Int {
        let calendar = Calendar.current
        let start = calendar.startOfDay(for: searchRequest.pickUpDate)
        let end = calendar.startOfDay(for: searchRequest.dropOffDate)
        let days = calendar.dateComponents([.day], from: start, to: end).day ?? 1
        return max(days, 1)
    }
    
    var selectedExtras: [ExtraService] {
        extraServices.filter { $0.isSelected || $0.quantity > 0 }
    }
    
    var extrasTotal: Double {
        selectedExtras.reduce(0) { partial, item in
            let quantity = max(item.quantity, 1)
            return partial + (item.pricePerDay * Double(quantity) * Double(dayCount))
        }
    }
    
    var grandTotal: Double {
        vehicle.totalPrice + extrasTotal
    }
}
