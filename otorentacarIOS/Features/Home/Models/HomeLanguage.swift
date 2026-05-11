//
//  HomeLanguage.swift
//  otorentacarIOS
//
//  Created by Codex on 10.05.2026.
//

import Foundation

enum HomeLanguage: String, CaseIterable, Identifiable {
    case turkish = "tr"
    case english = "en"

    var id: String { rawValue }

    var code: String {
        switch self {
        case .turkish:
            return "TR"
        case .english:
            return "EN"
        }
    }

    var flag: String {
        switch self {
        case .turkish:
            return "🇹🇷"
        case .english:
            return "🇬🇧"
        }
    }

    var alternate: HomeLanguage {
        switch self {
        case .turkish:
            return .english
        case .english:
            return .turkish
        }
    }
}
