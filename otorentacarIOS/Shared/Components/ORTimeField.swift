//
//  ORTimeField.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 8.04.2026.
//


import SwiftUI

struct ORTimeField: View {
    let title: String
    let placeholder: String
    @Binding var text: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title.uppercased())
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(AppColors.textSecondary)
            
            ZStack(alignment: .leading) {
                RoundedRectangle(cornerRadius: 16)
                    .fill(AppColors.inputBackground)
                    .frame(height: 58)
                
                if text.isEmpty {
                    Text(placeholder)
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(AppColors.textTertiary)
                        .padding(.horizontal, 16)
                }
                
                TextField("", text: $text)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(AppColors.textPrimary)
                    .padding(.horizontal, 16)
                    .keyboardType(.numbersAndPunctuation)
            }
        }
    }
}