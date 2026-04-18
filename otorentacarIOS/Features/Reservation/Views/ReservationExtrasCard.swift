//
//  ReservationExtrasCard.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 17.04.2026.
//


import SwiftUI

struct ReservationExtrasCard: View {
    let extras: [ExtraService]
    let currencyCode: String?

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Ek Hizmetler")
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(AppColors.textPrimary)

            ForEach(extras, id: \.id) { item in
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(item.title)
                            .font(.system(size: 17, weight: .semibold))
                            .foregroundColor(AppColors.textPrimary)

                        Text("Adet: \(max(item.quantity, 1))")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundColor(AppColors.textSecondary)
                    }

                    Spacer()

                    Text(FormatterHelper.currencyString(item.pricePerDay * Double(max(item.quantity, 1)), code: currencyCode))
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