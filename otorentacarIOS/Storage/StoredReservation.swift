//
//  StoredReservation.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 23.04.2026.
//


import Foundation

struct StoredReservation: Identifiable, Codable, Hashable {
    let id: UUID
    let trackingCode: String
    let vehicleName: String
    let vehicleBrand: String
    let imageURL: String?
    let pickUpLocation: String
    let dropOffLocation: String
    let pickUpDate: Date
    let dropOffDate: Date
    let totalAmount: Double
    let currencyCode: String?
    let status: String

    init(
        trackingCode: String,
        vehicleName: String,
        vehicleBrand: String,
        imageURL: String?,
        pickUpLocation: String,
        dropOffLocation: String,
        pickUpDate: Date,
        dropOffDate: Date,
        totalAmount: Double,
        currencyCode: String?,
        status: String
    ) {
        self.id = UUID()
        self.trackingCode = trackingCode
        self.vehicleName = vehicleName
        self.vehicleBrand = vehicleBrand
        self.imageURL = imageURL
        self.pickUpLocation = pickUpLocation
        self.dropOffLocation = dropOffLocation
        self.pickUpDate = pickUpDate
        self.dropOffDate = dropOffDate
        self.totalAmount = totalAmount
        self.currencyCode = currencyCode
        self.status = status
    }
}