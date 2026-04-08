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
}
