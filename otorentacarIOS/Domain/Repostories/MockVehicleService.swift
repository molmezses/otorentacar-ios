//
//  MockVehicleService.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 8.04.2026.
//

import Foundation

final class MockVehicleService: VehicleServiceProtocol {
    func fetchFeaturedVehicles() async throws -> [Vehicle] {
        [
            Vehicle(
                id: 1,
                name: "Clio",
                brand: "Renault",
                segment: "Economy Hatchback",
                transmission: "Manuel",
                fuelType: "Dizel",
                passengerCount: 5,
                baggageCount: 2,
                dailyPrice: 1250,
                totalPrice: 3750,
                imageURL: nil,
                badge: "POPULAR",
                isFavorite: true
            ),
            Vehicle(
                id: 2,
                name: "Corolla",
                brand: "Toyota",
                segment: "Eco Hybrid",
                transmission: "Otomatik",
                fuelType: "Hybrid",
                passengerCount: 5,
                baggageCount: 3,
                dailyPrice: 1850,
                totalPrice: 5550,
                imageURL: nil,
                badge: "ECO HYBRID",
                isFavorite: false
            )
        ]
    }
    
    func fetchVehicleSegments() async throws -> [VehicleSegment] {
        [
            VehicleSegment(id: 1, title: "Ekonomik", vehicleCount: 42, iconName: "car.fill"),
            VehicleSegment(id: 2, title: "Lüks", vehicleCount: 12, iconName: "star.circle.fill"),
            VehicleSegment(id: 3, title: "SUV", vehicleCount: 16, iconName: "car.2.fill")
        ]
    }
    
    func searchVehicles(request: ReservationSearchRequest) async throws -> [Vehicle] {
        try await fetchFeaturedVehicles()
    }
}
