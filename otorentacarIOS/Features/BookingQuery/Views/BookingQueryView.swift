//
//  BookingQueryView.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 8.04.2026.
//


import SwiftUI

struct BookingQueryView: View {
    @EnvironmentObject private var languageManager: AppLanguageManager
    @StateObject private var viewModel = BookingQueryViewModel()
    var onMenuTap: () -> Void
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 24) {
                    ORTopBar(onMenuTap: onMenuTap)
                    
                    titleSection
                    
                    imageSection
                    
                    BookingCodeInputCard(
                        bookingCode: $viewModel.bookingCode,
                        isLoading: viewModel.isLoading
                    ) {
                        viewModel.queryReservation(language: languageManager.language)
                    }
                    
                    if let errorMessage = viewModel.errorMessage {
                        Text(errorMessage)
                            .font(.system(size: 15, weight: .medium))
                            .foregroundColor(.red)
                            .padding(.horizontal, 4)
                    }
                    
                    infoSection
                }
                .padding(.horizontal, 24)
                .padding(.top, 20)
                .padding(.bottom, 24)
            }
            .background(AppColors.background)
            .navigationDestination(isPresented: $viewModel.navigateToDetail) {
                if let reservation = viewModel.foundReservation {
                    ReservationDetailView(
                        draft: reservation.toDraft(),
                        mode: .view(reservation)
                    )
                }
            }
        }
    }
    
    private var titleSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(languageManager.localized(turkish: "Rezervasyon Sorgula", english: "Booking Query"))
                .font(.system(size: 30, weight: .bold))
                .foregroundColor(AppColors.textPrimary)
            
            Text(languageManager.localized(
                turkish: "Takip kodun ile mevcut rezervasyon bilgilerine hızlıca ulaşabilirsin.",
                english: "Quickly access your booking details with your tracking code."
            ))
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(AppColors.textSecondary)
        }
    }
    
    private var imageSection: some View {
        HStack(spacing: 16) {
            RoundedRectangle(cornerRadius: 18)
                .fill(AppColors.primarySoft)
                .frame(width: 64, height: 64)
                .overlay(
                    Image(systemName: "doc.text.magnifyingglass")
                        .font(.system(size: 28, weight: .semibold))
                        .foregroundColor(AppColors.primary)
                )
            
            VStack(alignment: .leading, spacing: 6) {
                Text(languageManager.localized(turkish: "Rezervasyon Takibi", english: "Booking Tracking"))
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(AppColors.textPrimary)
                
                Text(languageManager.localized(
                    turkish: "Kodunu girerek mevcut rezervasyon detaylarını görüntüleyebilirsin.",
                    english: "Enter your code to view your existing booking details."
                ))
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(AppColors.textSecondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
            
            Spacer()
        }
        .padding(18)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .shadow(color: AppColors.shadow, radius: 10, x: 0, y: 6)
    }
    
    private var infoSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(languageManager.localized(turkish: "Nasıl Çalışır?", english: "How It Works"))
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(AppColors.textPrimary)
            
            queryInfoRow(
                number: "1",
                title: languageManager.localized(turkish: "Takip kodunu gir", english: "Enter your tracking code"),
                description: languageManager.localized(turkish: "Rezervasyon tamamlandığında sana verilen kodu yaz.", english: "Type the code you received after completing your booking.")
            )
            
            queryInfoRow(
                number: "2",
                title: languageManager.localized(turkish: "Sorgulamayı başlat", english: "Start the query"),
                description: languageManager.localized(turkish: "Butona bastığında sistem rezervasyonunu kontrol eder.", english: "The system checks your booking when you tap the button.")
            )
            
            queryInfoRow(
                number: "3",
                title: languageManager.localized(turkish: "Detaylarını görüntüle", english: "View the details"),
                description: languageManager.localized(turkish: "Bulunan rezervasyon detay ekranında açılır.", english: "The matching booking opens on the detail screen.")
            )
        }
    }
    
    private func queryInfoRow(number: String, title: String, description: String) -> some View {
        HStack(alignment: .top, spacing: 14) {
            Circle()
                .fill(AppColors.primarySoft)
                .frame(width: 36, height: 36)
                .overlay(
                    Text(number)
                        .font(.system(size: 16, weight: .bold))
                        .foregroundColor(AppColors.primary)
                )
            
            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(AppColors.textPrimary)
                
                Text(description)
                    .font(.system(size: 14, weight: .regular))
                    .foregroundColor(AppColors.textSecondary)
            }
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}
