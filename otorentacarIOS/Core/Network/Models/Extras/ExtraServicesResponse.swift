//
//  ExtraServicesResponse.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 14.04.2026.
//


import Foundation

struct ExtraServicesResponse: Codable {
    let status: Int
    let data: ExtraServicesResponseData?
    let description: String?
}

struct ExtraServicesResponseData: Codable {
    let list: [ExtraServiceDTO]?
}

struct ExtraServiceDTO: Codable {
    let id: Int
    let currency: ExtraServiceCurrencyDTO?
    let price: Double
    let orderNo: Int?
    let isActive: Int?
    let name: String
    let description: String?
    let imgPath: String?
    let maxCount: Int
    let iconCss: String?
    let priceCalculationType: ExtraServicePriceCalculationTypeDTO?
}

struct ExtraServiceCurrencyDTO: Codable {
    let id: Int?
    let active: Int?
    let symbolDirection: String?
    let symbol: String?
    let code: String?
    let name: String?
}

struct ExtraServicePriceCalculationTypeDTO: Codable {
    let id: Int?
    let name: String?
}

extension ExtraServiceDTO {
    func toDomain() -> ExtraService {
        ExtraService(
            id: id,
            title: name,
            description: description,
            pricePerDay: price,
            isSelected: false,
            quantity: 0,
            type: maxCount > 1 ? .quantity : .toggle
        )
    }
}
