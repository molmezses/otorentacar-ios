//
//  APIError.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 8.04.2026.
//

import Foundation

enum APIError: Error, LocalizedError {
    case invalidURL
    case invalidResponse
    case decodingFailed
    case serverError(Int)
    case unknown(Error)
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Geçersiz URL."
        case .invalidResponse:
            return "Geçersiz sunucu yanıtı."
        case .decodingFailed:
            return "Veri çözümlenemedi."
        case .serverError(let code):
            return "Sunucu hatası: \(code)"
        case .unknown(let error):
            return error.localizedDescription
        }
    }
}
