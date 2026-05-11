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
        localizedTitle(language: .turkish)
    }

    func localizedTitle(language: HomeLanguage) -> String {
        switch self {
        case .reservation:
            return language == .turkish ? "Rezervasyon" : "Book"
        case .myReservations:
            return language == .turkish ? "Rezervasyonlarım" : "Bookings"
        case .favorites:
            return language == .turkish ? "Favorilerim" : "Favorites"
        case .query:
            return language == .turkish ? "Sorgula" : "Query"
        case .contact:
            return language == .turkish ? "İletişim" : "Contact"
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
