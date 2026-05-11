//
//  PaymentSummaryCard.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 8.04.2026.
//


import SwiftUI

struct PaymentSummaryCard: View {
    @EnvironmentObject private var languageManager: AppLanguageManager

    let vehicleRentalTotal: Double
    let extrasTotal: Double
    let grandTotal: Double
    let currencyCode: String?
    let displayCurrency: PriceDisplayCurrency
    let rentalDayCount: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            HStack(spacing: 10) {
                Image(systemName: "creditcard.fill")
                    .foregroundColor(AppColors.primary)
                
                Text(languageManager.localized(turkish: "Ödeme Özeti", english: "Payment Summary"))
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(AppColors.textPrimary)
            }
            
            summaryRow(
                title: languageManager.localized(
                    turkish: "Araç Kiralama Bedeli (\(rentalDayCount) gün)",
                    english: "Car Rental Total (\(rentalDayCount) days)"
                ),
                value: vehicleRentalTotal
            )
            
            if extrasTotal > 0 {
                summaryRow(title: languageManager.localized(turkish: "Ek Hizmetler", english: "Extras"), value: extrasTotal)
            }
            
            Divider()
            
            VStack(alignment: .leading, spacing: 8) {
                Text(languageManager.localized(turkish: "GENEL TOPLAM", english: "GRAND TOTAL"))
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(AppColors.primary)
                
                Text(FormatterHelper.displayCurrencyString(
                    grandTotal,
                    originalCode: currencyCode,
                    displayCurrency: displayCurrency
                ))
                    .font(.system(size: 30, weight: .bold))
                    .foregroundColor(AppColors.textPrimary)
            }
            
            
        }
        .padding(20)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .shadow(color: AppColors.shadow, radius: 10, x: 0, y: 6)
    }
    
    private func summaryRow(title: String, value: Double) -> some View {
        HStack {
            Text(title)
                .font(.system(size: 17, weight: .regular))
                .foregroundColor(AppColors.textSecondary)
            
            Spacer()
            
            Text(FormatterHelper.displayCurrencyString(
                value,
                originalCode: currencyCode,
                displayCurrency: displayCurrency
            ))
                .font(.system(size: 17, weight: .bold))
                .foregroundColor(AppColors.textPrimary)
        }
    }
}
