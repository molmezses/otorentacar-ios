//
//  WhatsAppFloatingButton.swift
//  otorentacarIOS
//
//  Created by Codex on 10.05.2026.
//

import SwiftUI

struct WhatsAppFloatingButton: View {
    let phoneNumber: String
    let message: String

    var body: some View {
        Button {
            openWhatsApp()
        } label: {
            Circle()
                .fill(Color(red: 0.15, green: 0.82, blue: 0.40))
                .frame(width: 68, height: 68)
                .shadow(color: Color.black.opacity(0.18), radius: 12, x: 0, y: 6)
                .overlay(
                    Image(systemName: "phone.bubble.left.fill")
                        .font(.system(size: 29, weight: .bold))
                        .foregroundColor(.white)
                )
        }
        .accessibilityLabel("WhatsApp")
    }

    private func openWhatsApp() {
        let encodedMessage = message.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let appURLString = "whatsapp://send?phone=\(phoneNumber)&text=\(encodedMessage)"
        let webURLString = "https://wa.me/\(phoneNumber)?text=\(encodedMessage)"

        if let appURL = URL(string: appURLString), UIApplication.shared.canOpenURL(appURL) {
            UIApplication.shared.open(appURL)
        } else if let webURL = URL(string: webURLString) {
            UIApplication.shared.open(webURL)
        }
    }
}
