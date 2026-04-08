//
//  ORTabBar.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 8.04.2026.
//

import SwiftUI

struct ORTabBar: View {
    @Binding var selectedTab: AppTab
    
    var body: some View {
        HStack {
            ForEach(AppTab.allCases, id: \.self) { tab in
                Button {
                    selectedTab = tab
                } label: {
                    VStack(spacing: 8) {
                        ZStack {
                            if selectedTab == tab {
                                RoundedRectangle(cornerRadius: 16)
                                    .fill(AppColors.primarySoft)
                                    .frame(width: 72, height: 52)
                            }
                            
                            Image(systemName: tab.icon)
                                .font(.system(size: 22, weight: .medium))
                                .foregroundColor(selectedTab == tab ? AppColors.primary : Color.gray)
                        }
                        
                        Text(tab.title)
                            .font(.system(size: 11, weight: .medium))
                            .foregroundColor(selectedTab == tab ? AppColors.primary : Color.gray)
                    }
                    .frame(maxWidth: .infinity)
                }
            }
        }
        .padding(.horizontal, 18)
        .padding(.top, 14)
        .padding(.bottom, 18)
        .background(
            RoundedRectangle(cornerRadius: 28)
                .fill(.white)
                .shadow(color: AppColors.shadow, radius: 16, x: 0, y: -2)
        )
    }
}
