//
//  AddReservationResponse.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 16.04.2026.
//


struct AddReservationResponse: Codable {
    let status: Int
    let data: AddReservationData?
    let description: String?
}

struct AddReservationData: Codable {
    let reservationCode: String
}