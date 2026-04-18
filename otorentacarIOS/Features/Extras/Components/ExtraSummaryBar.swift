//
//  ExtraSummaryBar.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 8.04.2026.
//


import SwiftUI

struct ExtraSummaryBar: View {
    let vehicleTotal: Double
    let extrasTotal: Double
    let grandTotal: Double
    let currencyCode: String?
    let action: () -> Void
    
    var body: some View {
        VStack(spacing: 14) {
            HStack {
                summaryItem(title: "Araç", value: vehicleTotal)
                Spacer()
                summaryItem(title: "Ek Hizmet", value: extrasTotal)
                Spacer()
                summaryItem(title: "Toplam", value: grandTotal, isHighlighted: true)
            }
            
            ORPrimaryButton(title: "Devam Et", action: action)
        }
        .padding(.horizontal, 20)
        .padding(.top, 16)
        .padding(.bottom, 10)
        .background(
            RoundedRectangle(cornerRadius: 28)
                .fill(Color.white)
                .shadow(color: AppColors.shadow, radius: 14, x: 0, y: -4)
        )
    }
    
    private func summaryItem(title: String, value: Double, isHighlighted: Bool = false) -> some View {
        VStack(alignment: .leading, spacing: 4) {
            Text(title)
                .font(.system(size: 13, weight: .medium))
                .foregroundColor(AppColors.textSecondary)
            
            Text(FormatterHelper.currencyString(value, code: currencyCode))
                .font(.system(size: isHighlighted ? 20 : 16, weight: .bold))
                .foregroundColor(isHighlighted ? AppColors.primary : AppColors.textPrimary)
        }
    }
}
