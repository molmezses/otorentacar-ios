//
//  LocationResponse.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 13.04.2026.
//

import Foundation

struct LocationResponse: Codable {
    let status: Int
    let data: LocationResponseData?
    let description: String?
}

struct LocationResponseData: Codable {
    let list: [LocationDTO]?
}

struct LocationDTO: Codable {
    let id: Int
    let name: String
    let type: LocationTypeDTO?
    let address: String?
    let area: LocationAreaDTO?
}

struct LocationTypeDTO: Codable {
    let id: Int
    let name: String
}

struct LocationAreaDTO: Codable {
    let id: Int
    let name: String
}
