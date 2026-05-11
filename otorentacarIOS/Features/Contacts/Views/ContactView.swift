//
//  ContactView.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 8.04.2026.
//


import SwiftUI

struct ContactView: View {
    @EnvironmentObject private var languageManager: AppLanguageManager
    var onMenuTap: () -> Void
    
    private let phoneNumber = "+90 531 709 8838"
    private let email = "iletisim@otorentacar.com"
    private var address: String {
        languageManager.localized(
            turkish: "Kayseri Erkilet Havalimanı, Oto Rent A Car Ofis",
            english: "Kayseri Erkilet Airport, Oto Rent A Car Office"
        )
    }
    private let whatsappNumber = AppConstants.whatsappNumber
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 24) {
                ORTopBar(onMenuTap: onMenuTap)
                
                titleSection
                
                ContactActionButton(
                    title: "WhatsApp",
                    subtitle: languageManager.localized(turkish: "Hızlı destek için mesaj gönder", english: "Send a message for quick support"),
                    icon: "message.fill"
                ) {
                    openWhatsApp()
                }
                
                ContactInfoCard(
                    title: languageManager.localized(turkish: "Telefon", english: "Phone"),
                    value: phoneNumber,
                    icon: "phone.fill"
                )
                .onTapGesture {
                    callPhone()
                }
                
                ContactInfoCard(
                    title: languageManager.localized(turkish: "E-Posta", english: "Email"),
                    value: email,
                    icon: "envelope.fill"
                )
                .onTapGesture {
                    sendMail()
                }
                
                ContactInfoCard(
                    title: languageManager.localized(turkish: "Adres", english: "Address"),
                    value: address,
                    icon: "location.fill"
                )
                
                ContactMapCard()
            }
            .padding(.horizontal, 24)
            .padding(.top, 20)
            .padding(.bottom, 24)
        }
        .background(AppColors.background)
    }
    
    private var titleSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(languageManager.localized(turkish: "İletişim", english: "Contact"))
                .font(.system(size: 30, weight: .bold))
                .foregroundColor(AppColors.textPrimary)
            
            Text(languageManager.localized(turkish: "Bize ulaşmanın en kolay yolu", english: "The easiest way to reach us"))
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(AppColors.primary)
            
            Text(languageManager.localized(
                turkish: "Telefon, e-posta ve WhatsApp üzerinden bizimle hızlıca iletişime geçebilirsiniz.",
                english: "You can quickly contact us by phone, email, or WhatsApp."
            ))
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(AppColors.textSecondary)
        }
    }
    
    private func openWhatsApp() {
        let appURLString = "whatsapp://send?phone=\(whatsappNumber)"
        let webURLString = "https://wa.me/\(whatsappNumber)"
        
        if let appURL = URL(string: appURLString), UIApplication.shared.canOpenURL(appURL) {
            UIApplication.shared.open(appURL)
        } else if let webURL = URL(string: webURLString) {
            UIApplication.shared.open(webURL)
        }
    }
    
    private func callPhone() {
        let cleaned = phoneNumber.replacingOccurrences(of: " ", with: "")
        if let url = URL(string: "tel://\(cleaned)") {
            UIApplication.shared.open(url)
        }
    }
    
    private func sendMail() {
        if let url = URL(string: "mailto:\(email)") {
            UIApplication.shared.open(url)
        }
    }
}
