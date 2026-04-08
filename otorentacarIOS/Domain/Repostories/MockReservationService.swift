//
//  ReservationVehicleService.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 8.04.2026.
//

import Foundation

final class MockReservationService: ReservationServiceProtocol {
    func fetchReservation(by trackingCode: String) async throws -> Reservation {
        let trimmedCode = trackingCode.trimmingCharacters(in: .whitespacesAndNewlines)
        
        try await Task.sleep(nanoseconds: 800_000_000)
        
        guard !trimmedCode.isEmpty, trimmedCode.count >= 4 else {
            throw APIError.invalidResponse
        }
        
        let vehicle = Vehicle(
            id: 11,
            name: "Golf",
            brand: "Volkswagen",
            segment: "Ekonomi",
            transmission: "Otomatik",
            fuelType: "Benzin",
            passengerCount: 5,
            baggageCount: 3,
            dailyPrice: 1400,
            totalPrice: 4200,
            imageURL: nil,
            badge: "EKONOMİ",
            isFavorite: false
        )
        
        return Reservation(
            id: 1,
            trackingCode: trimmedCode,
            vehicle: vehicle,
            pickUpLocation: "Sabiha Gökçen Havalimanı",
            dropOffLocation: "Sabiha Gökçen Havalimanı",
            pickUpDate: Date(),
            dropOffDate: Calendar.current.date(byAdding: .day, value: 3, to: Date()) ?? Date(),
            totalAmount: 5580,
            status: "Onaylandı"
        )
    }
}

