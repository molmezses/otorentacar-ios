//
//  SıdeMenuItem.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 8.04.2026.
//

import Foundation

struct SideMenuItem: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let icon: String
    let destination: SideMenuDestination
}

enum SideMenuDestination: Hashable {
    case home
    case myReservations
    case favorites
    case query
    case about
    case services
    case contact
}


