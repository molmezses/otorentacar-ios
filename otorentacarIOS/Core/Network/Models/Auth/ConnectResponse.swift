//
//  ConnectResponse.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 10.04.2026.
//


import Foundation

struct ConnectResponse: Codable {
    let status: Int
    let data: ConnectData?
    let description: String?
}

struct ConnectData: Codable {
    let token: String
    let lifetime: String
}