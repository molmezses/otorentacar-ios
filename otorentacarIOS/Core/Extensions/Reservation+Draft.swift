//
//  Reservation+Draft.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 8.04.2026.
//

import Foundation

extension Reservation {
    func toDraft() -> ReservationDraft {
        ReservationDraft(
            pickUpLocation: nil,
            dropOffLocation: nil,
            pickUpDate: pickUpDate,
            pickUpTime: pickUpDate,
            dropOffDate: dropOffDate,
            dropOffTime: dropOffDate,
            selectedVehicle: vehicle,
            selectedVehicleModelId: vehicle.id,
            currencyId: nil,
            currencyCode: nil,
            selectedExtras: [],
            customerInfo: CustomerInfo()
        )
    }
}
