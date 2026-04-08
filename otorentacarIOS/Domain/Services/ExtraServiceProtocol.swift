//
//  ExtraServiceProtocol.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 8.04.2026.
//


import Foundation

protocol ExtraServiceProtocol {
    func fetchExtraServices(for vehicle: Vehicle) async throws -> [ExtraService]
}