//
//  ExtraServicesServiceProtocol.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 14.04.2026.
//


import Foundation

protocol ExtraServicesServiceProtocol {
    func fetchExtraServices() async throws -> [ExtraServiceDTO]
}