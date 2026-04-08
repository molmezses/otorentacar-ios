//
//  ContactActionButton.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 8.04.2026.
//


import SwiftUI

struct ContactActionButton: View {
    let title: String
    let subtitle: String
    let icon: String
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 14) {
                RoundedRectangle(cornerRadius: 16)
                    .fill(AppColors.primarySoft)
                    .frame(width: 54, height: 54)
                    .overlay(
                        Image(systemName: icon)
                            .font(.system(size: 22, weight: .semibold))
                            .foregroundColor(AppColors.primary)
                    )
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(title)
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(AppColors.textSecondary)
                    
                    Text(subtitle)
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(AppColors.textPrimary)
                        .multilineTextAlignment(.leading)
                }
                
                Spacer()
            }
            .padding(18)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 22))
            .shadow(color: AppColors.shadow, radius: 10, x: 0, y: 6)
        }
    }
}