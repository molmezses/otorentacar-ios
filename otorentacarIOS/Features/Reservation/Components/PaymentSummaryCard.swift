//
//  PaymentSummaryCard.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 8.04.2026.
//


import SwiftUI

struct PaymentSummaryCard: View {
    let vehicleRentalTotal: Double
    let extrasTotal: Double
    let taxAmount: Double
    let grandTotal: Double
    
    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            HStack(spacing: 10) {
                Image(systemName: "creditcard.fill")
                    .foregroundColor(AppColors.primary)
                
                Text("Ödeme Özeti")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(AppColors.textPrimary)
            }
            
            summaryRow(title: "Araç Kiralama Bedeli", value: vehicleRentalTotal)
            
            if extrasTotal > 0 {
                summaryRow(title: "Ek Hizmetler", value: extrasTotal)
            }
            
            summaryRow(title: "KDV (%20)", value: taxAmount)
            
            Divider()
            
            VStack(alignment: .leading, spacing: 8) {
                Text("GENEL TOPLAM")
                    .font(.system(size: 14, weight: .bold))
                    .foregroundColor(AppColors.primary)
                
                Text(FormatterHelper.fullCurrency.string(from: NSNumber(value: grandTotal)) ?? "₺0,00")
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
            
            Text(FormatterHelper.fullCurrency.string(from: NSNumber(value: value)) ?? "₺0,00")
                .font(.system(size: 17, weight: .bold))
                .foregroundColor(AppColors.textPrimary)
        }
    }
}