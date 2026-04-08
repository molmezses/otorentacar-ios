//
//  ReservationDraft.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 8.04.2026.
//


import Foundation

struct ReservationDraft {
    let vehicle: Vehicle
    let searchRequest: ReservationSearchRequest
    let extras: [ExtraService]
    var customerInfo: CustomerInfo
    
    init(
        vehicle: Vehicle,
        searchRequest: ReservationSearchRequest,
        extras: [ExtraService],
        customerInfo: CustomerInfo = CustomerInfo()
    ) {
        self.vehicle = vehicle
        self.searchRequest = searchRequest
        self.extras = extras
        self.customerInfo = customerInfo
    }
}
