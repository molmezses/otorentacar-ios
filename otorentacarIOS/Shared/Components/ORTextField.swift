//
//  ORTextField.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 8.04.2026.
//

import SwiftUI

struct ORTextField: View {
    let title: String
    let placeholder: String
    @Binding var text: String
    var icon: String? = nil
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title.uppercased())
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(AppColors.textSecondary)
            
            HStack(spacing: 12) {
                if let icon {
                    Image(systemName: icon)
                        .foregroundColor(AppColors.primary)
                        .font(.system(size: 18, weight: .semibold))
                }
                
                ZStack(alignment: .leading) {
                    if text.isEmpty {
                        Text(placeholder)
                            .foregroundColor(AppColors.textTertiary.opacity(0.9))
                            .font(.system(size: 18, weight: .medium))
                    }
                    
                    TextField("", text: $text)
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(AppColors.textPrimary)
                }
            }
            .padding()
            .frame(height: 58)
            .background(AppColors.inputBackground)
            .clipShape(RoundedRectangle(cornerRadius: 16))
        }
    }
}
