//
//  ReservationServiceProtocol.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 8.04.2026.
//

import Foundation

protocol ReservationServiceProtocol {
    func fetchReservation(by code: String) async throws -> Reservation
}
