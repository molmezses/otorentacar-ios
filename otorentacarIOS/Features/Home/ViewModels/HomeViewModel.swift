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
    @Published var pickUpLocation: String = ""
    @Published var dropOffLocation: String = ""
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

    private let vehicleService: VehicleServiceProtocol

    init(vehicleService: VehicleServiceProtocol) {
        self.vehicleService = vehicleService
    }

    convenience init() {
        self.init(vehicleService: MockVehicleService())
    }

    func onAppear() {
        Task {
            await loadHomeData()
        }
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

    func buildSearchRequest() -> ReservationSearchRequest {
        ReservationSearchRequest(
            pickUpLocation: pickUpLocation,
            dropOffLocation: dropOffDifferentLocation ? dropOffLocation : pickUpLocation,
            pickUpDate: pickUpDate,
            dropOffDate: dropOffDate,
            pickUpTime: FormatterHelper.timeString.string(from: pickUpTime),
            dropOffTime: FormatterHelper.timeString.string(from: dropOffTime)
        )
    }
}
