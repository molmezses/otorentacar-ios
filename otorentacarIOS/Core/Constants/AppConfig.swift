//
//  AppConfig.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 10.04.2026.
//


import Foundation

enum AppConfig {
    
    static var baseURL: String {
        value(for: "API_BASE_URL")
    }
    
    static var apiUsername: String {
        value(for: "API_USERNAME")
    }
    
    static var apiPassword: String {
        value(for: "API_PASSWORD")
    }
    
    private static func value(for key: String) -> String {
        guard let value = Bundle.main.object(forInfoDictionaryKey: key) as? String,
              !value.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        else {
            fatalError("Missing config for \(key)")
        }
        return value
    }
}
