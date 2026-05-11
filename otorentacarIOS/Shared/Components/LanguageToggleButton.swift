//
//  LanguageToggleButton.swift
//  otorentacarIOS
//
//  Created by Codex on 10.05.2026.
//

import SwiftUI

struct LanguageToggleButton: View {
    @EnvironmentObject private var languageManager: AppLanguageManager

    var body: some View {
        Button {
            languageManager.toggleLanguage()
        } label: {
            HStack(spacing: 6) {
                Text(languageManager.language.flag)
                    .font(.system(size: 17))

                Text(languageManager.language.code)
                    .font(.system(size: 13, weight: .bold))
                    .foregroundColor(AppColors.primary)
            }
            .padding(.horizontal, 10)
            .frame(height: 36)
            .background(AppColors.primarySoft)
            .clipShape(Capsule())
        }
        .accessibilityLabel(languageManager.localized(turkish: "Dil seçimi", english: "Language selector"))
    }
}
