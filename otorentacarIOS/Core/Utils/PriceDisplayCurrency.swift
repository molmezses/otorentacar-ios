//
//  PriceDisplayCurrency.swift
//  otorentacarIOS
//
//  Created by Codex on 10.05.2026.
//

import Foundation

enum PriceDisplayCurrency: String, CaseIterable, Identifiable, Codable {
    case eur = "EUR"
    case tryCurrency = "TRY"

    var id: String { rawValue }

    var title: String {
        switch self {
        case .eur:
            return "Euro"
        case .tryCurrency:
            return "TL"
        }
    }

    var shortTitle: String {
        switch self {
        case .eur:
            return "€"
        case .tryCurrency:
            return "₺"
        }
    }
}
