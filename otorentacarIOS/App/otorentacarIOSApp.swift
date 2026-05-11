//
//  otorentacarIOSApp.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 8.04.2026.
//

import SwiftUI

@main
struct otorentacarIOSApp: App {
    @StateObject private var languageManager = AppLanguageManager()

    var body: some Scene {
        WindowGroup {
            MainContainerView()
                .environmentObject(languageManager)
        }
    }
}
