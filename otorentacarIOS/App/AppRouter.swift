//
//  AppRouter.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 8.04.2026.
//

import Foundation

enum AppTab: CaseIterable, Hashable {
    case reservation
    case myReservations
    case favorites
    case query
    case contact

    var title: String {
        switch self {
        case .reservation: return "Rezervasyon"
        case .myReservations: return "Rezervasyonlarım"
        case .favorites: return "Favorilerim"
        case .query: return "Sorgula"
        case .contact: return "İletişim"
        }
    }

    var icon: String {
        switch self {
        case .reservation: return "house.fill"
        case .myReservations: return "calendar"
        case .favorites: return "heart.fill"
        case .query: return "magnifyingglass"
        case .contact: return "headphones"
        }
    }
}
