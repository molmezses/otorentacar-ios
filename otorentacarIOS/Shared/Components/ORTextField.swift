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
                }
                
                TextField(placeholder, text: $text)
                    .foregroundColor(AppColors.textPrimary)
            }
            .padding()
            .frame(height: 58)
            .background(AppColors.inputBackground)
            .clipShape(RoundedRectangle(cornerRadius: 16))
        }
    }
}
