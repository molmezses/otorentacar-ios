//
//  ReservationServiceProtocol.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 8.04.2026.
//

import Foundation

protocol ReservationServiceProtocol {
    func fetchReservation(by trackingCode: String) async throws -> Reservation
}
