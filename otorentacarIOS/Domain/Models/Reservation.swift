//
//  Reservation.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 8.04.2026.
//

import Foundation

struct Reservation: Identifiable, Codable, Hashable {
    let id: Int
    let trackingCode: String
    let vehicle: Vehicle
    let pickUpLocation: String
    let dropOffLocation: String
    let pickUpDate: Date
    let dropOffDate: Date
    let totalAmount: Double
    let status: String
    let extras: [SearchReservationExtraItemDTO]

    let fullName: String
    let email: String
    let phone: String
    let birthDate: Date?
    let pickUpLocationPointId: Int?
    let dropOffLocationPointId: Int?
}
