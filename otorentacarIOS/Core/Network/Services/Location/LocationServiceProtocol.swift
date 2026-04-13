//
//  LocationServiceProtocol.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 13.04.2026.
//


import Foundation

protocol LocationServiceProtocol {
    func fetchLocations() async throws -> [LocationDTO]
}