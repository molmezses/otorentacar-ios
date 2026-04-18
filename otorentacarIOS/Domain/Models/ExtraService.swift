//
//  ExtraService.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 8.04.2026.
//

import Foundation

struct ExtraService: Identifiable, Codable, Hashable {
    let id: Int
    let title: String
    let description: String?
    let pricePerDay: Double
    let maxCount: Int
    var isSelected: Bool
    var quantity: Int
    let type: ExtraServiceType
}

enum ExtraServiceType: String, Codable, Hashable {
    case toggle
    case quantity
    case single
}
