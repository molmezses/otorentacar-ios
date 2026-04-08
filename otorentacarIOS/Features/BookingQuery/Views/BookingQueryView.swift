//
//  BookingQueryView.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 8.04.2026.
//


import SwiftUI

struct BookingQueryView: View {
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
                        viewModel.queryReservation()
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
                    ReservationDetailView(draft: reservation.toDraft())
                }
            }
        }
    }
    
    private var titleSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Rezervasyon Sorgula")
                .font(.system(size: 30, weight: .bold))
                .foregroundColor(AppColors.textPrimary)
            
            Text("Takip kodun ile mevcut rezervasyon bilgilerine hızlıca ulaşabilirsin.")
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(AppColors.textSecondary)
        }
    }
    
    private var imageSection: some View {
        RoundedRectangle(cornerRadius: 28)
            .fill(Color.white)
            .frame(height: 220)
            .overlay(
                VStack(spacing: 16) {
                    Image(systemName: "doc.text.magnifyingglass")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 74)
                        .foregroundColor(AppColors.primary)
                    
                    Text("Kodunu gir, rezervasyonunu görüntüle")
                        .font(.system(size: 20, weight: .semibold))
                        .foregroundColor(AppColors.textPrimary)
                }
            )
            .shadow(color: AppColors.shadow, radius: 12, x: 0, y: 6)
    }
    
    private var infoSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Nasıl Çalışır?")
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(AppColors.textPrimary)
            
            queryInfoRow(
                number: "1",
                title: "Takip kodunu gir",
                description: "Rezervasyon tamamlandığında sana verilen kodu yaz."
            )
            
            queryInfoRow(
                number: "2",
                title: "Sorgulamayı başlat",
                description: "Butona bastığında sistem rezervasyonunu kontrol eder."
            )
            
            queryInfoRow(
                number: "3",
                title: "Detaylarını görüntüle",
                description: "Bulunan rezervasyon detay ekranında açılır."
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