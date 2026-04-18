//
//  SearchReservationResponse.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 17.04.2026.
//


import Foundation

struct SearchReservationResponse: Codable {
    let status: Int
    let data: SearchReservationResponseData?
    let description: String?
}

struct SearchReservationResponseData: Codable {
    let object: SearchReservationDTO?
}

struct SearchReservationDTO: Codable {
    let id: Int
    let vehicleModel: SearchReservationVehicleModelDTO?
    let fullname: String?
    let email: String?
    let phone1: String?
    let birthDate: String?
    let reservationCode: String?
    let pickUpDateTime: String?
    let dropOffDateTime: String?
    let status: SearchReservationStatusDTO?
    let recordDate: String?
    let lastUpdateDate: String?
    let currency: SearchReservationCurrencyDTO?
    let totalPrice: Double?
    let extraList: [SearchReservationExtraItemDTO]?
    let pickUpLocationPoint: SearchReservationLocationPointDTO?
    let dropOffLocationPoint: SearchReservationLocationPointDTO?
    let reservationPaymentMethod: SearchReservationPaymentMethodDTO?
    let reservationSource: String?
}

struct SearchReservationVehicleModelDTO: Codable {
    let modelId: Int?
    let brand: SearchReservationBrandDTO?
    let engine: SearchReservationEngineDTO?
    let transmission: SearchReservationTransmissionDTO?
    let name: String?
    let year: Int?
}

struct SearchReservationBrandDTO: Codable {
    let id: Int?
    let name: String?
}

struct SearchReservationEngineDTO: Codable {
    let id: Int?
    let name: String?
}

struct SearchReservationTransmissionDTO: Codable {
    let id: Int?
    let name: String?
}

struct SearchReservationStatusDTO: Codable {
    let id: Int?
    let name: String?
}

struct SearchReservationCurrencyDTO: Codable, Hashable {
    let id: Int?
    let code: String?
    let name: String?
}

struct SearchReservationExtraItemDTO: Codable, Hashable {
    let extra: SearchReservationExtraDTO?
    let count: Int?
}

struct SearchReservationExtraDTO: Codable, Hashable {
    let id: Int?
    let currency: SearchReservationCurrencyDTO?
    let price: Double?
    let name: String?
    let description: String?
}

struct SearchReservationLocationPointDTO: Codable {
    let id: Int?
    let name: String?
}

struct SearchReservationPaymentMethodDTO: Codable {
    let id: Int?
    let name: String?
}

extension SearchReservationDTO {
    func toDomain() -> Reservation {
        let pickUp = FormatterHelper.reservationDateTimeParser.date(from: pickUpDateTime ?? "") ?? Date()
        let dropOff = FormatterHelper.reservationDateTimeParser.date(from: dropOffDateTime ?? "") ?? Date()
        let parsedBirthDate = FormatterHelper.birthDateParser.date(from: birthDate ?? "")

        let vehicle = Vehicle(
            id: vehicleModel?.modelId ?? 0,
            name: vehicleModel?.name ?? "Araç",
            brand: vehicleModel?.brand?.name ?? "",
            segment: "Rezervasyon Aracı",
            transmission: vehicleModel?.transmission?.name ?? "",
            fuelType: vehicleModel?.engine?.name ?? "",
            passengerCount: 0,
            baggageCount: 0,
            dailyPrice: 0,
            totalPrice: totalPrice ?? 0,
            imageURL: nil,
            badge: nil,
            isFavorite: false,
            currencyId: currency?.id,
            currencyCode: currency?.code
        )

        return Reservation(
            id: id,
            trackingCode: reservationCode ?? "",
            vehicle: vehicle,
            pickUpLocation: pickUpLocationPoint?.name ?? "",
            dropOffLocation: dropOffLocationPoint?.name ?? "",
            pickUpDate: pickUp,
            dropOffDate: dropOff,
            totalAmount: totalPrice ?? 0,
            status: status?.name ?? "Bilinmiyor",
            extras: extraList ?? [],
            fullName: fullname ?? "",
            email: email ?? "",
            phone: phone1 ?? "",
            birthDate: parsedBirthDate,
            pickUpLocationPointId: pickUpLocationPoint?.id,
            dropOffLocationPointId: dropOffLocationPoint?.id,
        )
    }
}
