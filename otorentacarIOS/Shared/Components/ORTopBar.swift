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
    
    var body: some View {
        HStack {
            Button(action: onMenuTap) {
                Image(systemName: "line.3.horizontal")
                    .font(.system(size: 24, weight: .medium))
                    .foregroundColor(AppColors.primary)
            }
            
            Text("Otorentacar")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(AppColors.textPrimary)
            
            Spacer()
            
            
        }
    }
}
