//
//  MockVehicleService.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 8.04.2026.
//

import Foundation

final class MockVehicleService: VehicleServiceProtocol {
    func fetchFeaturedVehicles() async throws -> [Vehicle] {
        sampleVehicles.shuffled().prefix(3).map { $0 }
    }
    
    func fetchVehicleSegments() async throws -> [VehicleSegment] {
        [
            VehicleSegment(id: 1, title: "Ekonomik", vehicleCount: 42, iconName: "car.fill"),
            VehicleSegment(id: 2, title: "Lüks", vehicleCount: 12, iconName: "star.circle.fill"),
            VehicleSegment(id: 3, title: "SUV", vehicleCount: 16, iconName: "car.2.fill"),
            VehicleSegment(id: 4, title: "Elektrikli", vehicleCount: 8, iconName: "bolt.car.fill")
        ]
    }
    
    func searchVehicles(request: ReservationSearchRequest) async throws -> [Vehicle] {
        sampleVehicles
    }
    
    private var sampleVehicles: [Vehicle] {
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
                isFavorite: true,
                currencyId: 4,
                currencyCode: "EUR"
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
                isFavorite: false,
                currencyId: 4,
                currencyCode: "EUR"
            ),
            Vehicle(
                id: 3,
                name: "Egea",
                brand: "Fiat",
                segment: "Sedan",
                transmission: "Manuel",
                fuelType: "Benzin",
                passengerCount: 5,
                baggageCount: 3,
                dailyPrice: 1150,
                totalPrice: 3450,
                imageURL: nil,
                badge: "FIRSAT",
                isFavorite: false,
                currencyId: 4,
                currencyCode: "EUR"
            ),
            Vehicle(
                id: 4,
                name: "3008",
                brand: "Peugeot",
                segment: "SUV",
                transmission: "Otomatik",
                fuelType: "Dizel",
                passengerCount: 5,
                baggageCount: 4,
                dailyPrice: 2350,
                totalPrice: 7050,
                imageURL: nil,
                badge: "SUV",
                isFavorite: true,
                currencyId: 4,
                currencyCode: "EUR"
            ),
            Vehicle(
                id: 5,
                name: "Tiguan",
                brand: "Volkswagen",
                segment: "Premium SUV",
                transmission: "Otomatik",
                fuelType: "Benzin",
                passengerCount: 5,
                baggageCount: 4,
                dailyPrice: 2950,
                totalPrice: 8850,
                imageURL: nil,
                badge: "PREMIUM",
                isFavorite: false,
                currencyId: 4,
                currencyCode: "EUR"
            )
        ]
    }
}
