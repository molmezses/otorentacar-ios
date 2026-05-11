//
//  ORTopBar.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 8.04.2026.
//

import SwiftUI

struct ORTopBar: View {
    var onMenuTap: () -> Void
    var profileTap: (() -> Void)? = nil
    var trailingContent: AnyView? = nil
    
    var body: some View {
        HStack {
            Button(action: onMenuTap) {
                Image(systemName: "line.3.horizontal")
                    .font(.system(size: 24, weight: .medium))
                    .foregroundColor(AppColors.primary)
            }
            
            OtorentacarLogoView(width: 142, height: 44, cornerRadius: 12)
            
            Spacer()

            if let trailingContent {
                trailingContent
                    .layoutPriority(1)
            } else {
                LanguageToggleButton()
                    .layoutPriority(1)
            }
        }
        .frame(maxWidth: .infinity)
    }
}
