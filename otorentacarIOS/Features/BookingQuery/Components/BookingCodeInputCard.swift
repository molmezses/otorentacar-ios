//
//  BookingCodeInputCard.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 8.04.2026.
//


import SwiftUI

struct BookingCodeInputCard: View {
    @EnvironmentObject private var languageManager: AppLanguageManager
    @Binding var bookingCode: String
    let isLoading: Bool
    let action: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            VStack(alignment: .leading, spacing: 10) {
                Text(languageManager.localized(turkish: "REZERVASYON TAKİP KODU", english: "BOOKING TRACKING CODE"))
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(AppColors.textSecondary)
                
                HStack(spacing: 12) {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(AppColors.primary)
                    
                    TextField(languageManager.localized(turkish: "Örn: RTR2026", english: "Ex: RTR2026"), text: $bookingCode)
                        .textInputAutocapitalization(.characters)
                        .autocorrectionDisabled()
                        .foregroundColor(AppColors.textPrimary)
                }
                .padding()
                .frame(height: 58)
                .background(AppColors.inputBackground)
                .clipShape(RoundedRectangle(cornerRadius: 16))
            }
            
            ORPrimaryButton(
                title: isLoading
                    ? languageManager.localized(turkish: "Sorgulanıyor...", english: "Searching...")
                    : languageManager.localized(turkish: "Rezervasyonumu Bul", english: "Find My Booking"),
                action: action
            )
            .disabled(isLoading)
            .opacity(isLoading ? 0.7 : 1)
        }
        .padding(20)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 28))
        .shadow(color: AppColors.shadow, radius: 14, x: 0, y: 8)
    }
}
