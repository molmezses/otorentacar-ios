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
        
        let pickUpDate = Date()
        let dropOffDate = Calendar.current.date(byAdding: .day, value: 3, to: pickUpDate) ?? pickUpDate
        
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
            isFavorite: false,
            currencyId: 4,
            currencyCode: "EUR"
        )
        
        return Reservation(
            id: 1,
            trackingCode: trimmedCode,
            vehicle: vehicle,
            pickUpLocation: "Kayseri Erkilet Havalimanı",
            dropOffLocation: "Kayseri Erkilet Havalimanı",
            pickUpDate: pickUpDate,
            dropOffDate: dropOffDate,
            totalAmount: 1200,
            status: "Onaylandı",
            extras: [],
            fullName: "Test Kullanıcı",
            email: "test@example.com",
            phone: "05000000000",
            birthDate: Calendar.current.date(byAdding: .year, value: -25, to: Date()),
            pickUpLocationPointId: 1,
            dropOffLocationPointId: 1
        )
    }
}
