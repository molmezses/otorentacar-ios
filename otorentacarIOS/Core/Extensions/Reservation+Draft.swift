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
            vehicle: vehicle,
            searchRequest: ReservationSearchRequest(
                pickUpLocation: pickUpLocation,
                dropOffLocation: dropOffLocation,
                pickUpDate: pickUpDate,
                dropOffDate: dropOffDate,
                pickUpTime: "10:00",
                dropOffTime: "10:00"
            ),
            extras: []
        )
    }
}
