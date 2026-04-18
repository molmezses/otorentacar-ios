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
        case .home: return "Rezervasyon"
        case .bookings: return "Rezervasyon Sorgula"
        case .contact: return "Iletisim"
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
