//
//  PriceSearchResponse.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 14.04.2026.
//


import Foundation

struct PriceSearchResponse: Codable {
    let status: Int
    let data: PriceSearchResponseData?
    let description: String?
}

struct PriceSearchResponseData: Codable {
    let list: [VehiclePriceDTO]?
}

struct VehiclePriceDTO: Codable {
    let modelId: Int
    let brand: VehicleBrandDTO
    let type: VehicleTypeDTO?
    let engine: VehicleEngineDTO
    let transmission: VehicleTransmissionDTO
    let name: String
    let maxPassenger: Int
    let maxSmallBaggage: Int?
    let maxBigBaggage: Int?
    let doorCount: Int?
    let hasGps: Bool?
    let hasFrontSensor: Bool?
    let hasBackSensor: Bool?
    let hasAirConditioner: Bool?
    let hasRadio: Bool?
    let hasCdPlayer: Bool?
    let year: Int?
    let pricing: VehiclePricingDTO
    let vehicleModelClass: VehicleModelClassDTO?
    let orderNo: Int?
}

struct VehicleBrandDTO: Codable {
    let id: Int?
    let name: String
}

struct VehicleTypeDTO: Codable {
    let id: Int?
    let name: String
    let activeInTransfer: Bool?
    let imageList: [String]?
}

struct VehicleEngineDTO: Codable {
    let id: Int?
    let name: String
}

struct VehicleTransmissionDTO: Codable {
    let id: Int?
    let name: String
}

struct VehiclePricingDTO: Codable {
    let season: VehicleSeasonDTO?
    let dailyPrice: Double
    let currency: VehicleCurrencyDTO
}

struct VehicleSeasonDTO: Codable {
    let startDate: String?
    let endDate: String?
}

struct VehicleCurrencyDTO: Codable {
    let id: Int?
    let code: String
}

struct VehicleModelClassDTO: Codable {
    let id: Int?
    let name: String
}

extension VehiclePriceDTO {
    func toDomain(rentalDayCount: Int) -> Vehicle {
        Vehicle(
            id: modelId,
            name: name,
            brand: brand.name,
            segment: vehicleModelClass?.name ?? type?.name ?? "Araç",
            transmission: transmission.name,
            fuelType: engine.name,
            passengerCount: maxPassenger,
            baggageCount: maxBigBaggage ?? maxSmallBaggage ?? 0,
            dailyPrice: pricing.dailyPrice,
            totalPrice: pricing.dailyPrice * Double(rentalDayCount),
            imageURL: nil,
            badge: vehicleModelClass?.name,
            isFavorite: false,
            currencyId: pricing.currency.id,
            currencyCode: pricing.currency.code
        )
    }
}
