//
//  ContactInfoCard.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 8.04.2026.
//


import SwiftUI

struct ContactInfoCard: View {
    let title: String
    let value: String
    let icon: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 14) {
            RoundedRectangle(cornerRadius: 14)
                .fill(AppColors.primarySoft)
                .frame(width: 46, height: 46)
                .overlay(
                    Image(systemName: icon)
                        .foregroundColor(AppColors.primary)
                        .font(.system(size: 20, weight: .semibold))
                )
            
            VStack(alignment: .leading, spacing: 6) {
                Text(title)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(AppColors.textSecondary)
                
                Text(value)
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(AppColors.textPrimary)
                    .fixedSize(horizontal: false, vertical: true)
            }
            
            Spacer()
        }
        .padding(18)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 22))
        .shadow(color: AppColors.shadow, radius: 10, x: 0, y: 6)
    }
}