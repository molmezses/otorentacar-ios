//
//  ExtraServiceCard.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 8.04.2026.
//


import SwiftUI

struct ExtraServiceCard: View {
    @EnvironmentObject private var languageManager: AppLanguageManager

    let item: ExtraService
    let dayCount: Int
    let onToggle: () -> Void
    let onIncrease: () -> Void
    let onDecrease: () -> Void
    let currencyCode: String?
    let displayCurrency: PriceDisplayCurrency
    let childrenAges: [String]
    let onChildAgeChange: ((Int, String) -> Void)?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(alignment: .top, spacing: 14) {
                Button(action: onToggle) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(item.isSelected ? AppColors.primary : AppColors.border, lineWidth: 2)
                            .frame(width: 28, height: 28)
                        
                        if item.isSelected {
                            Image(systemName: "checkmark")
                                .font(.system(size: 14, weight: .bold))
                                .foregroundColor(AppColors.primary)
                        }
                    }
                }
                
                VStack(alignment: .leading, spacing: 6) {
                    Text(item.title)
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(AppColors.textPrimary)
                    
                    if let description = item.description {
                        Text(description)
                            .font(.system(size: 14, weight: .regular))
                            .foregroundColor(AppColors.textSecondary)
                            .fixedSize(horizontal: false, vertical: true)
                    }
                }
                
                Spacer()
            }
            
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text(languageManager.localized(turkish: "Günlük Ücret", english: "Daily Price"))
                        .font(.system(size: 13, weight: .medium))
                        .foregroundColor(AppColors.textSecondary)
                    
                    Text(FormatterHelper.displayCurrencyString(
                        item.pricePerDay,
                        originalCode: currencyCode,
                        displayCurrency: displayCurrency
                    ))
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(AppColors.primary)

                    Text(languageManager.localized(
                        turkish: "\(dayCount) gün toplam ",
                        english: "\(dayCount) days total "
                    ) + FormatterHelper.displayCurrencyString(
                        item.pricePerDay * Double(max(item.quantity, 1)) * Double(dayCount),
                        originalCode: currencyCode,
                        displayCurrency: displayCurrency
                    ))
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(AppColors.textSecondary)
                }
                
                Spacer()
                
                if item.type == .quantity {
                    HStack(spacing: 12) {
                        if item.quantity > 0 {
                            quantityButton(icon: "minus", action: onDecrease)
                        }
                        
                        Text("\(item.quantity)")
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(AppColors.textPrimary)
                            .monospacedDigit()
                            .frame(minWidth: 24)
                        
                        if item.quantity < item.maxCount {
                            quantityButton(icon: "plus", action: onIncrease)
                        }
                    }
                }  else {
                    Text(languageManager.localized(turkish: "\(dayCount) gün", english: "\(dayCount) days"))
                        .font(.system(size: 15, weight: .medium))
                        .foregroundColor(AppColors.textSecondary)
                }
                
                if item.title.lowercased().contains("bebek koltuğu"), item.quantity > 0 {
                    VStack(alignment: .leading, spacing: 10) {
                        ForEach(0..<item.quantity, id: \.self) { index in
                            VStack(alignment: .leading, spacing: 6) {
                                Text(languageManager.localized(
                                    turkish: "\(index + 1). Çocuk Yaşı",
                                    english: "Child \(index + 1) Age"
                                ))
                                    .font(.system(size: 13, weight: .medium))
                                    .foregroundColor(AppColors.textSecondary)

                                TextField(
                                    languageManager.localized(turkish: "Yaş giriniz", english: "Enter age"),
                                    text: Binding(
                                        get: {
                                            index < childrenAges.count ? childrenAges[index] : ""
                                        },
                                        set: { newValue in
                                            onChildAgeChange?(index, newValue)
                                        }
                                    )
                                )
                                .keyboardType(.numberPad)
                                .padding(.horizontal, 14)
                                .frame(height: 46)
                                .background(AppColors.inputBackground)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                            }
                        }
                    }
                    .padding(.top, 4)
                }
            }
        }
        .padding(18)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .shadow(color: AppColors.shadow, radius: 10, x: 0, y: 6)
    }
    
    private func quantityButton(icon: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            RoundedRectangle(cornerRadius: 12)
                .fill(AppColors.primarySoft)
                .frame(width: 36, height: 36)
                .overlay(
                    Image(systemName: icon)
                        .foregroundColor(AppColors.primary)
                        .font(.system(size: 14, weight: .bold))
                )
        }
    }
}
