//
//  ORPrimaryButton.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 8.04.2026.
//

import SwiftUI

struct ORPrimaryButton: View {
    let title: String
    var icon: String? = nil
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack(spacing: 10) {
                Text(title)
                    .font(.system(size: 24, weight: .semibold))
                
                if let icon {
                    Image(systemName: icon)
                        .font(.system(size: 20, weight: .medium))
                }
            }
            .foregroundColor(.white)
            .frame(maxWidth: .infinity)
            .frame(height: 68)
            .background(AppColors.primary)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(color: AppColors.primary.opacity(0.20), radius: 12, x: 0, y: 8)
        }
    }
}
