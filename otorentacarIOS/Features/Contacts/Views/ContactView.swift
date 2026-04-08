//
//  ContactView.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 8.04.2026.
//


import SwiftUI

struct ContactView: View {
    var onMenuTap: () -> Void
    
    private let phoneNumber = "+90 531 709 8838"
    private let email = "iletisim@otorentacar.com"
    private let address = "Kayseri Erkilet Havalimanı, Oto Rent A Car Ofis"
    private let whatsappNumber = "905317098838"
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 24) {
                ORTopBar(onMenuTap: onMenuTap)
                
                titleSection
                
                ContactActionButton(
                    title: "WhatsApp",
                    subtitle: "Hızlı destek için mesaj gönder",
                    icon: "message.fill"
                ) {
                    openWhatsApp()
                }
                
                ContactInfoCard(
                    title: "Telefon",
                    value: phoneNumber,
                    icon: "phone.fill"
                )
                .onTapGesture {
                    callPhone()
                }
                
                ContactInfoCard(
                    title: "E-Posta",
                    value: email,
                    icon: "envelope.fill"
                )
                .onTapGesture {
                    sendMail()
                }
                
                ContactInfoCard(
                    title: "Adres",
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
            Text("İletişim")
                .font(.system(size: 30, weight: .bold))
                .foregroundColor(AppColors.textPrimary)
            
            Text("Bize ulaşmanın en kolay yolu")
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(AppColors.primary)
            
            Text("Telefon, e-posta ve WhatsApp üzerinden bizimle hızlıca iletişime geçebilirsiniz.")
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