//
//  CustomerInfo.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 8.04.2026.
//


import Foundation

struct CustomerInfo: Hashable {
    var name: String
    var surname: String
    var phone: String
    var birthDate: Date
    var email: String
    var flightCode: String

    init(
        name: String = "",
        surname: String = "",
        phone: String = "",
        birthDate: Date = Calendar.current.date(byAdding: .year, value: -20, to: Date()) ?? Date(),
        email: String = "",
        flightCode: String = ""
    ) {
        self.name = name
        self.surname = surname
        self.phone = phone
        self.birthDate = birthDate
        self.email = email
        self.flightCode = flightCode
    }
}
