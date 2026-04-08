//
//  SideMenuView.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 8.04.2026.
//

import SwiftUI

struct SideMenuView: View {
    let items: [SideMenuItem] = [
        .init(title: "Anasayfa", icon: "house.fill"),
        .init(title: "Rezervasyonlarım", icon: "car.fill"),
        .init(title: "Hakkımızda", icon: "info.circle.fill"),
        .init(title: "Hizmetlerimiz", icon: "cross.case.fill"),
        .init(title: "S.S.S", icon: "questionmark.square.fill"),
        .init(title: "Blog", icon: "newspaper.fill"),
        .init(title: "İletişim", icon: "at")
    ]
    
    var closeAction: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 28) {
            HStack(alignment: .top) {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color.black.opacity(0.85))
                    .frame(width: 92, height: 92)
                    .overlay(
                        Image(systemName: "person.fill")
                            .foregroundColor(.white)
                            .font(.system(size: 30))
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(AppColors.primary, lineWidth: 2)
                    )
                
                VStack(alignment: .leading, spacing: 6) {
                    Text("Hoş Geldiniz,\nMisafir")
                        .font(.system(size: 24, weight: .bold))
                    Text("Giriş Yap / Kaydol")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(AppColors.primary)
                }
                
                Spacer()
                
                Button(action: closeAction) {
                    Image(systemName: "xmark")
                        .font(.system(size: 22, weight: .medium))
                        .foregroundColor(AppColors.textSecondary)
                }
            }
            
            Text("Otorentacar")
                .font(.system(size: 28, weight: .bold))
            
            VStack(alignment: .leading, spacing: 18) {
                ForEach(items) { item in
                    HStack(spacing: 16) {
                        Image(systemName: item.icon)
                            .frame(width: 28)
                            .foregroundColor(item.title == "Anasayfa" ? AppColors.primary : AppColors.textSecondary)
                        
                        Text(item.title)
                            .font(.system(size: 20, weight: item.title == "Anasayfa" ? .semibold : .regular))
                            .foregroundColor(item.title == "Anasayfa" ? AppColors.primary : AppColors.textSecondary)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(item.title == "Anasayfa" ? AppColors.primarySoft : .clear)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                }
            }
            
            Spacer()
        }
        .padding(28)
        .frame(maxWidth: 320, maxHeight: .infinity, alignment: .topLeading)
        .background(Color.white)
    }
}

#Preview {
    SideMenuView(closeAction: {
        
    })
}
