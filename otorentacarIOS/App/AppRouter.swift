//
//  AppRouter.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 8.04.2026.
//

import Foundation

enum AppTab: String, CaseIterable {
    case home
    case bookings
    case search
    case contact
    
    var title: String {
        switch self {
        case .home: return "HOME"
        case .bookings: return "MY BOOKINGS"
        case .search: return "SEARCH"
        case .contact: return "CONTACT"
        }
    }
    
    var icon: String {
        switch self {
        case .home: return "house.fill"
        case .bookings: return "calendar"
        case .search: return "magnifyingglass"
        case .contact: return "person.crop.circle.badge.questionmark"
        }
    }
}
