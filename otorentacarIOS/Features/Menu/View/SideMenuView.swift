//
//  SideMenuView.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 8.04.2026.
//

import SwiftUI

struct SideMenuView: View {
    @EnvironmentObject private var languageManager: AppLanguageManager
    
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
                            
                            Text(item.title(language: languageManager.language))
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

    private var items: [SideMenuItem] {
        [
            .init(turkishTitle: "Anasayfa", englishTitle: "Home", icon: "house.fill", destination: .home),
            .init(turkishTitle: "Rezervasyonlarım", englishTitle: "My Bookings", icon: "car.fill", destination: .myReservations),
            .init(turkishTitle: "Favorilerim", englishTitle: "Favorites", icon: "heart.fill", destination: .favorites),
            .init(turkishTitle: "Sorgula", englishTitle: "Query", icon: "magnifyingglass", destination: .query),
            .init(turkishTitle: "Hakkımızda", englishTitle: "About Us", icon: "info.circle.fill", destination: .about),
            .init(turkishTitle: "Hizmetlerimiz", englishTitle: "Services", icon: "cross.case.fill", destination: .services),
            .init(turkishTitle: "İletişim", englishTitle: "Contact", icon: "at", destination: .contact)
        ]
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
                    .font(.system(size: 24, weight: .bold))                    .foregroundColor(AppColors.textPrimary)
                
                Text(languageManager.localized(turkish: "Hoş geldiniz", english: "Welcome"))
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(AppColors.primary)
                
                Text(languageManager.localized(
                    turkish: "Araç kiralama işlemlerini hızlı ve kolay şekilde yönetebilirsiniz.",
                    english: "Manage car rental tasks quickly and easily."
                ))
                    .font(.system(size: 15, weight: .regular))
                    .foregroundColor(AppColors.textSecondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
    }
    
    private var logoView: some View {
        OtorentacarLogoView(width: 142, height: 44, cornerRadius: 11)
    }
}
