//
//  PriceSearchServiceProtocol.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 14.04.2026.
//


import Foundation

protocol PriceSearchServiceProtocol {
    func searchPrices(request: PriceSearchRequest) async throws -> [VehiclePriceDTO]
}