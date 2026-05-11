//
//  AppLanguageManager.swift
//  otorentacarIOS
//
//  Created by Codex on 10.05.2026.
//

import Combine
import Foundation

@MainActor
final class AppLanguageManager: ObservableObject {
    @Published var language: HomeLanguage = .turkish

    func toggleLanguage() {
        language = language.alternate
    }

    func localized(turkish: String, english: String) -> String {
        language == .turkish ? turkish : english
    }

    func localizedVehicleSpec(_ value: String) -> String {
        let cleaned = value.trimmingCharacters(in: .whitespacesAndNewlines)
        let lowercased = cleaned.lowercased()

        switch lowercased {
        case "automatic", "auto", "otomatik":
            return language == .turkish ? "Otomatik" : "Automatic"
        case "manual", "manuel", "düz vites":
            return language == .turkish ? "Manuel" : "Manual"
        case "diesel", "dizel":
            return language == .turkish ? "Dizel" : "Diesel"
        case "gasoline", "petrol", "benzin", "benzinli":
            return language == .turkish ? "Benzin" : "Gasoline"
        case "hybrid", "hibrit":
            return language == .turkish ? "Hibrit" : "Hybrid"
        case "electric", "elektrik", "elektrikli":
            return language == .turkish ? "Elektrik" : "Electric"
        default:
            return cleaned
        }
    }

    func shortDateString(from date: Date) -> String {
        dateFormatter(format: "dd MMM yyyy").string(from: date)
    }

    func fullDateString(from date: Date) -> String {
        dateFormatter(format: "dd MMM yyyy, HH:mm").string(from: date)
    }

    private func dateFormatter(format: String) -> DateFormatter {
        let formatter = DateFormatter()
        formatter.locale = language == .turkish ? Locale(identifier: "tr_TR") : Locale(identifier: "en_US")
        formatter.dateFormat = format
        return formatter
    }
}
