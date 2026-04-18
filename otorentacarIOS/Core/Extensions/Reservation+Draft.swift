//
//  Reservation+Draft.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 8.04.2026.
//

import Foundation

extension Reservation {
    func toDraft() -> ReservationDraft {
        let nameParts = fullName.split(separator: " ").map(String.init)
        let firstName = nameParts.first ?? ""
        let surname = nameParts.dropFirst().joined(separator: " ")

        return ReservationDraft(
            pickUpLocation: nil,
            dropOffLocation: nil,
            pickUpDate: pickUpDate,
            pickUpTime: pickUpDate,
            dropOffDate: dropOffDate,
            dropOffTime: dropOffDate,
            selectedVehicle: vehicle,
            selectedVehicleModelId: vehicle.id,
            currencyId: vehicle.currencyId,
            currencyCode: vehicle.currencyCode,
            selectedExtras: [],
            customerInfo: CustomerInfo(
                name: firstName,
                surname: surname,
                phone: phone,
                birthDate: birthDate ?? Date(),
                email: email,
                flightCode: ""
            ), childrenAges: []
        )
    }
}
