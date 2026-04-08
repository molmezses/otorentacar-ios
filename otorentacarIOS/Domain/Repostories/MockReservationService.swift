//
//  ReservationVehicleService.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 8.04.2026.
//

import Foundation

final class MockReservationService: ReservationServiceProtocol {
    func fetchReservation(by trackingCode: String) async throws -> Reservation {
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
            trackingCode: trackingCode,
            vehicle: vehicle,
            pickUpLocation: "Sabiha Gökçen Havalimanı",
            dropOffLocation: "Sabiha Gökçen Havalimanı",
            pickUpDate: Date(),
            dropOffDate: Date().addingTimeInterval(60 * 60 * 24 * 3),
            totalAmount: 5580,
            status: "Onaylandı"
        )
    }
}
