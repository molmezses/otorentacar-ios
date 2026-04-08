//
//  VehicleListViewModel.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 8.04.2026.
//


import Foundation
import Combine

@MainActor
final class VehicleListViewModel: ObservableObject {
    @Published var vehicles: [Vehicle] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    @Published var selectedSortOption: VehicleSortOption = .recommended
    @Published var selectedFilterTitle: String = "Filtrele"
    
    let searchRequest: ReservationSearchRequest
    
    private let vehicleService: VehicleServiceProtocol
    
    init(
        searchRequest: ReservationSearchRequest,
        vehicleService: VehicleServiceProtocol
    ) {
        self.searchRequest = searchRequest
        self.vehicleService = vehicleService
    }
    
    convenience init(searchRequest: ReservationSearchRequest) {
        self.init(
            searchRequest: searchRequest,
            vehicleService: MockVehicleService()
        )
    }
    
    func onAppear() {
        Task {
            await fetchVehicles()
        }
    }
    
    func fetchVehicles() async {
        isLoading = true
        errorMessage = nil
        
        do {
            let result = try await vehicleService.searchVehicles(request: searchRequest)
            vehicles = sortVehicles(result, by: selectedSortOption)
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    func applySort(_ option: VehicleSortOption) {
        selectedSortOption = option
        vehicles = sortVehicles(vehicles, by: option)
    }
    
    private func sortVehicles(_ vehicles: [Vehicle], by option: VehicleSortOption) -> [Vehicle] {
        switch option {
        case .recommended:
            return vehicles
        case .priceLowToHigh:
            return vehicles.sorted { $0.dailyPrice < $1.dailyPrice }
        case .priceHighToLow:
            return vehicles.sorted { $0.dailyPrice > $1.dailyPrice }
        case .nameAscending:
            return vehicles.sorted { "\($0.brand) \($0.name)" < "\($1.brand) \($1.name)" }
        }
    }
}

enum VehicleSortOption: String, CaseIterable, Identifiable {
    case recommended = "Önerilen"
    case priceLowToHigh = "Fiyat Artan"
    case priceHighToLow = "Fiyat Azalan"
    case nameAscending = "A-Z"
    
    var id: String { rawValue }
}
