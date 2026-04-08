//
//  VehicleServiceProtocol.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 8.04.2026.
//

import Foundation

protocol VehicleServiceProtocol {
    func fetchFeaturedVehicles() async throws -> [Vehicle]
    func fetchVehicleSegments() async throws -> [VehicleSegment]
    func searchVehicles(request: ReservationSearchRequest) async throws -> [Vehicle]
}
