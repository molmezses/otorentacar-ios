//
//  HomeViewModel.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 8.04.2026.
//

import Foundation
import Combine

@MainActor
final class HomeViewModel: ObservableObject {
    @Published var selectedPickUpLocation: LocationDTO?
    @Published var selectedDropOffLocation: LocationDTO?
    @Published var availableLocations: [LocationDTO] = []
    @Published var pickUpDate: Date = Date()
    @Published var dropOffDate: Date = Calendar.current.date(byAdding: .day, value: 3, to: Date()) ?? Date()
    @Published var pickUpTime: Date = {
        var components = DateComponents()
        components.hour = 10
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }()
    @Published var dropOffDifferentLocation: Bool = false

    @Published var featuredVehicles: [Vehicle] = []
    @Published var segments: [VehicleSegment] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var dropOffTime: Date = {
        var components = DateComponents()
        components.hour = 10
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date()
    }()
    
    @Published var showSearchErrorAlert: Bool = false
    @Published var searchErrorMessage: String = ""

    private let vehicleService: VehicleServiceProtocol
    
    private let authService: AuthServiceProtocol = AuthAPIService()

    private let locationService: LocationServiceProtocol
    
    


    init(
        vehicleService: VehicleServiceProtocol,
        locationService: LocationServiceProtocol
    ) {
        self.vehicleService = vehicleService
        self.locationService = locationService
    }

    
    convenience init() {
        self.init(
            vehicleService: MockVehicleService(),
            locationService: LocationAPIService()
        )
    }
    

    func onAppear() {
        Task {
            await loadLocations()
            await loadHomeData()
        }
    }
    
    func validateSearchForm() -> Bool {
        guard selectedPickUpLocation != nil else {
            searchErrorMessage = "Lütfen alış lokasyonu seçin."
            showSearchErrorAlert = true
            return false
        }

        if dropOffDifferentLocation && selectedDropOffLocation == nil {
            searchErrorMessage = "Lütfen iade lokasyonu seçin."
            showSearchErrorAlert = true
            return false
        }

        let pickUpCombined = FormatterHelper.combine(date: pickUpDate, time: pickUpTime)
        let dropOffCombined = FormatterHelper.combine(date: dropOffDate, time: dropOffTime)

        let minimumPickUpDate = Date().addingTimeInterval(60 * 60)

        if pickUpCombined < minimumPickUpDate {
            searchErrorMessage = "Alış tarihi en az 1 saat sonrası olmalıdır."
            showSearchErrorAlert = true
            return false
        }

        if dropOffCombined <= pickUpCombined {
            searchErrorMessage = "İade tarihi, alış tarihinden sonra olmalıdır."
            showSearchErrorAlert = true
            return false
        }

        return true
    }
    
    

    func loadHomeData() async {
        isLoading = true
        errorMessage = nil

        do {
            async let featured = vehicleService.fetchFeaturedVehicles()
            async let segments = vehicleService.fetchVehicleSegments()

            self.featuredVehicles = try await featured
            self.segments = try await segments
        } catch {
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }
    
    func loadLocations() async {
        do {
            let locations = try await locationService.fetchLocations()
            self.availableLocations = locations
            
            if selectedPickUpLocation == nil {
                selectedPickUpLocation = locations.first
            }
            
            if selectedDropOffLocation == nil {
                selectedDropOffLocation = locations.first
            }
        } catch {
            errorMessage = error.localizedDescription
        }
    }

    func buildSearchRequest() -> ReservationSearchRequest {
        ReservationSearchRequest(
            pickUpLocation: selectedPickUpLocation?.name ?? "",
            dropOffLocation: dropOffDifferentLocation
                ? (selectedDropOffLocation?.name ?? "")
                : (selectedPickUpLocation?.name ?? ""),
            pickUpDate: pickUpDate,
            dropOffDate: dropOffDate,
            pickUpTime: FormatterHelper.timeString.string(from: pickUpTime),
            dropOffTime: FormatterHelper.timeString.string(from: dropOffTime)
        )
    }
    
    func buildPriceSearchRequest() -> PriceSearchRequest? {
        guard let token = InMemoryTokenStore.shared.fetchToken(),
              let pickUpLocation = selectedPickUpLocation,
              let dropOffLocation = dropOffDifferentLocation ? selectedDropOffLocation : selectedPickUpLocation
        else {
            return nil
        }
        
        let pickUpCombined = FormatterHelper.combine(date: pickUpDate, time: pickUpTime)
        let dropOffCombined = FormatterHelper.combine(date: dropOffDate, time: dropOffTime)
        
        return PriceSearchRequest(
            token: token,
            pickUpDateTime: FormatterHelper.apiDateTime.string(from: pickUpCombined),
            dropOffDateTime: FormatterHelper.apiDateTime.string(from: dropOffCombined),
            pickUpLocationPointId: pickUpLocation.id,
            dropOffLocationPointId: dropOffLocation.id
        )
    }
    
    func buildReservationDraft() -> ReservationDraft? {
        guard let pickUpLocation = selectedPickUpLocation else {
            return nil
        }
        
        let finalDropOffLocation = dropOffDifferentLocation
            ? selectedDropOffLocation
            : selectedPickUpLocation
        
        guard let dropOffLocation = finalDropOffLocation else {
            return nil
        }
        
        return ReservationDraft(
            pickUpLocation: pickUpLocation,
            dropOffLocation: dropOffLocation,
            pickUpDate: pickUpDate,
            pickUpTime: pickUpTime,
            dropOffDate: dropOffDate,
            dropOffTime: dropOffTime
        )
    }
    
    func resetForm() {
        let now = Date()

        pickUpDate = now
        dropOffDate = Calendar.current.date(byAdding: .day, value: 3, to: now) ?? now

        var components = DateComponents()
        components.hour = 10
        components.minute = 0

        pickUpTime = Calendar.current.date(from: components) ?? now
        dropOffTime = Calendar.current.date(from: components) ?? now

        dropOffDifferentLocation = false

        selectedPickUpLocation = availableLocations.first
        selectedDropOffLocation = availableLocations.first

        showSearchErrorAlert = false
        searchErrorMessage = ""
        errorMessage = nil
    }
    
    
    
}
