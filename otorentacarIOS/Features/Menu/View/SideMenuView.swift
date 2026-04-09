//
//  SideMenuView.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 8.04.2026.
//

import SwiftUI

struct SideMenuView: View {
    let items: [SideMenuItem] = [
        .init(title: "Anasayfa", icon: "house.fill", destination: .home),
        .init(title: "Rezervasyonlarım", icon: "car.fill", destination: .bookings),
        .init(title: "Hakkımızda", icon: "info.circle.fill", destination: .about),
        .init(title: "Hizmetlerimiz", icon: "cross.case.fill", destination: .services),
        .init(title: "S.S.S", icon: "questionmark.square.fill", destination: .faq),
        .init(title: "İletişim", icon: "at", destination: .contact)
    ]
    
    let selectedDestination: SideMenuDestination
    var onItemTap: (SideMenuDestination) -> Void
    var closeAction: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 28) {
            topSection
            
            VStack(alignment: .leading, spacing: 18) {
                ForEach(items) { item in
                    Button {
                        onItemTap(item.destination)
                    } label: {
                        HStack(spacing: 16) {
                            Image(systemName: item.icon)
                                .frame(width: 28)
                                .foregroundColor(
                                    selectedDestination == item.destination
                                    ? AppColors.primary
                                    : AppColors.textSecondary
                                )
                            
                            Text(item.title)
                                .font(.system(size: 20, weight: selectedDestination == item.destination ? .semibold : .regular))
                                .foregroundColor(
                                    selectedDestination == item.destination
                                    ? AppColors.primary
                                    : AppColors.textSecondary
                                )
                        }
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(selectedDestination == item.destination ? AppColors.primarySoft : .clear)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                    }
                }
            }
            
            Spacer()
        }
        .padding(28)
        .frame(maxWidth: 320, maxHeight: .infinity, alignment: .topLeading)
        .background(Color.white)
    }
    
    private var topSection: some View {
        VStack(alignment: .leading, spacing: 18) {
            HStack(alignment: .top) {
                logoView
                
                Spacer()
                
                Button(action: closeAction) {
                    Image(systemName: "xmark")
                        .font(.system(size: 22, weight: .medium))
                        .foregroundColor(AppColors.textSecondary)
                }
            }
            
            VStack(alignment: .leading, spacing: 8) {
                Text("Otorentacar")
                    .font(.system(size: 30, weight: .bold))
                    .foregroundColor(AppColors.textPrimary)
                
                Text("Hoş geldiniz")
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(AppColors.primary)
                
                Text("Araç kiralama işlemlerini hızlı ve kolay şekilde yönetebilirsiniz.")
                    .font(.system(size: 15, weight: .regular))
                    .foregroundColor(AppColors.textSecondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
    }
    
    private var logoView: some View {
        RoundedRectangle(cornerRadius: 22)
            .fill(AppColors.primarySoft)
            .frame(width: 84, height: 84)
            .overlay(
                Image(systemName: "car.side.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 42)
                    .foregroundColor(AppColors.primary)
            )
            .overlay(
                RoundedRectangle(cornerRadius: 22)
                    .stroke(AppColors.primary.opacity(0.15), lineWidth: 1.5)
            )
    }
}
