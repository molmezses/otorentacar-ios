//
//  ReservationExtrasCard.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 17.04.2026.
//


import SwiftUI

struct ReservationExtrasCard: View {
    @EnvironmentObject private var languageManager: AppLanguageManager

    let extras: [ExtraService]
    let currencyCode: String?
    let displayCurrency: PriceDisplayCurrency
    let rentalDayCount: Int

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(languageManager.localized(turkish: "Ek Hizmetler", english: "Extras"))
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(AppColors.textPrimary)

            ForEach(extras, id: \.id) { item in
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(item.title)
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundColor(AppColors.textPrimary)

                        Text(languageManager.localized(
                            turkish: "Adet: \(max(item.quantity, 1)) • \(rentalDayCount) gün",
                            english: "Qty: \(max(item.quantity, 1)) • \(rentalDayCount) days"
                        ))
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(AppColors.textSecondary)
                    }

                    Spacer()

                    Text(FormatterHelper.displayCurrencyString(
                        item.pricePerDay * Double(max(item.quantity, 1)) * Double(rentalDayCount),
                        originalCode: currencyCode,
                        displayCurrency: displayCurrency
                    ))
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(AppColors.primary)
                }

                if item.id != extras.last?.id {
                    Divider()
                }
            }
        }
        .padding(20)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .shadow(color: AppColors.shadow, radius: 10, x: 0, y: 6)
    }
}
