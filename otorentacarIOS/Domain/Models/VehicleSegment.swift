//
//  VehicleSegment.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 8.04.2026.
//

import Foundation

struct VehicleSegment: Identifiable, Codable, Hashable {
    let id: Int
    let title: String
    let vehicleCount: Int
    let iconName: String
}
