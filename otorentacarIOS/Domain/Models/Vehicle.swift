//
//  Vehicle.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 8.04.2026.
//

import Foundation

struct Vehicle: Identifiable, Codable, Hashable {
    let id: Int
    let name: String
    let brand: String
    let segment: String
    let transmission: String
    let fuelType: String
    let passengerCount: Int
    let baggageCount: Int
    let dailyPrice: Double
    let totalPrice: Double
    let imageURL: String?
    let badge: String?
    let isFavorite: Bool
    let currencyId: Int?
    let currencyCode: String?
}
