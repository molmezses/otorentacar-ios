//
//  FeaturedVehicleCard..swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 8.04.2026.
//

import Foundation

struct ReservationSearchRequest: Codable {
    let pickUpLocation: String
    let dropOffLocation: String?
    let pickUpDate: Date
    let dropOffDate: Date
    let pickUpTime: String
    let dropOffTime: String
}
