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
    case contact
    
    var title: String {
        switch self {
        case .home: return "HOME"
        case .bookings: return "MY BOOKINGS"
        case .contact: return "CONTACT"
        }
    }
    
    var icon: String {
        switch self {
        case .home: return "house.fill"
        case .bookings: return "calendar"
        case .contact: return "headphones"
        }
    }
}
