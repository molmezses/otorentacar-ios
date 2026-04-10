//
//  AuthServiceProtocol.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 10.04.2026.
//


protocol AuthServiceProtocol {
    func connect() async throws -> String
}