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

    let draft: ReservationDraft
    private let priceSearchService: PriceSearchServiceProtocol

    init(
        draft: ReservationDraft,
        priceSearchService: PriceSearchServiceProtocol
    ) {
        self.draft = draft
        self.priceSearchService = priceSearchService
    }

    convenience init(draft: ReservationDraft) {
        self.init(
            draft: draft,
            priceSearchService: PriceSearchAPIService()
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
            guard let request = buildPriceSearchRequest() else {
                errorMessage = "Araç arama bilgileri eksik."
                isLoading = false
                return
            }

            let result = try await priceSearchService.searchPrices(request: request)
            let mappedVehicles = result.map { dto in
                dto.toDomain(rentalDayCount: rentalDayCount)
            }
            vehicles = sortVehicles(mappedVehicles, by: selectedSortOption)
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }

    func applySort(_ option: VehicleSortOption) {
        selectedSortOption = option
        vehicles = sortVehicles(vehicles, by: option)
    }

    func buildDraft(with vehicle: Vehicle) -> ReservationDraft {
        ReservationDraft(
            pickUpLocation: draft.pickUpLocation,
            dropOffLocation: draft.dropOffLocation,
            pickUpDate: draft.pickUpDate,
            pickUpTime: draft.pickUpTime,
            dropOffDate: draft.dropOffDate,
            dropOffTime: draft.dropOffTime,
            selectedVehicle: vehicle,
            selectedVehicleModelId: vehicle.id,
            currencyId: vehicle.currencyId,
            currencyCode: vehicle.currencyCode,
            selectedExtras: draft.selectedExtras,
            customerInfo: draft.customerInfo
        )
    }

    private func buildPriceSearchRequest() -> PriceSearchRequest? {
        guard let token = InMemoryTokenStore.shared.fetchToken(),
              let pickUpLocation = draft.pickUpLocation,
              let dropOffLocation = draft.dropOffLocation
        else {
            return nil
        }

        let pickUpCombined = FormatterHelper.combine(date: draft.pickUpDate, time: draft.pickUpTime)
        let dropOffCombined = FormatterHelper.combine(date: draft.dropOffDate, time: draft.dropOffTime)

        return PriceSearchRequest(
            token: token,
            pickUpDateTime: FormatterHelper.apiDateTime.string(from: pickUpCombined),
            dropOffDateTime: FormatterHelper.apiDateTime.string(from: dropOffCombined),
            pickUpLocationPointId: pickUpLocation.id,
            dropOffLocationPointId: dropOffLocation.id
        )
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
    
    private var rentalDayCount: Int {
        let calendar = Calendar.current
        let start = calendar.startOfDay(for: draft.pickUpDate)
        let end = calendar.startOfDay(for: draft.dropOffDate)
        let days = calendar.dateComponents([.day], from: start, to: end).day ?? 1
        return max(days, 1)
    }
}

enum VehicleSortOption: String, CaseIterable, Identifiable {
    case recommended = "Önerilen"
    case priceLowToHigh = "Fiyat Artan"
    case priceHighToLow = "Fiyat Azalan"
    case nameAscending = "A-Z"

    var id: String { rawValue }
}

