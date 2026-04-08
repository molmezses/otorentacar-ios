//
//  CustomerInfo.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 8.04.2026.
//


import Foundation

struct CustomerInfo: Codable, Hashable {
    var fullName: String = ""
    var phone: String = ""
    var birthDate: Date = Date()
    var email: String = ""
    var flightCode: String = ""
}