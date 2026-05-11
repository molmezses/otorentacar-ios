//
//  MyReservationsView.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 23.04.2026.
//


import SwiftUI

struct MyReservationsView: View {
    @EnvironmentObject private var languageManager: AppLanguageManager
    var onCreateReservationTap: (() -> Void)? = nil
    
    @State private var reservations: [StoredReservation] = []
    @State private var fetchedReservation: Reservation?
    @State private var navigateToDetail = false
    @State private var isLoadingDetail = false
    @State private var errorMessage: String?
    
    private let reservationService: ReservationServiceProtocol = SearchReservationAPIService()
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    Text(languageManager.localized(turkish: "Rezervasyonlarım", english: "My Bookings"))
                        .font(.system(size: 30, weight: .bold))
                        .foregroundColor(AppColors.textPrimary)

                    Spacer()

                    LanguageToggleButton()
                }
                .frame(maxWidth: .infinity)
                
                if reservations.isEmpty {
                    VStack(spacing: 14) {
                        Image(systemName: "calendar.badge.exclamationmark")
                            .font(.system(size: 42))
                            .foregroundColor(AppColors.primary)
                        
                        Text(languageManager.localized(turkish: "Henüz kayıtlı rezervasyonunuz yok", english: "You do not have saved bookings yet"))
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(AppColors.textPrimary)
                        
                        Text(languageManager.localized(
                            turkish: "Yeni bir rezervasyon oluşturduğunuzda burada görüntüleyebilirsiniz.",
                            english: "When you create a new booking, you can view it here."
                        ))
                            .font(.system(size: 15, weight: .medium))
                            .foregroundColor(AppColors.textSecondary)
                            .multilineTextAlignment(.center)
                        
                        Button {
                            onCreateReservationTap?()
                        } label: {
                            Text(languageManager.localized(turkish: "Rezervasyon Oluştur", english: "Create Booking"))
                                .font(.system(size: 16, weight: .semibold))
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity)
                                .frame(height: 52)
                                .background(AppColors.primary)
                                .clipShape(RoundedRectangle(cornerRadius: 16))
                        }
                        .padding(.top, 10)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.top, 80)
                } else {
                    LazyVStack(spacing: 16) {
                        ForEach(reservations) { reservation in
                            reservationCard(reservation)
                        }
                    }
                }
                
                if let errorMessage {
                    Text(errorMessage)
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.red)
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            .padding(.bottom, 24)
        }
        .background(AppColors.background.ignoresSafeArea())
        .onAppear {
            reservations = LocalStorageManager.shared.fetchReservations()
        }
        .navigationDestination(isPresented: $navigateToDetail) {
            if let fetchedReservation {
                ReservationDetailView(
                    draft: fetchedReservation.toDraft(),
                    mode: .view(fetchedReservation)
                )
            }
        }
        .overlay {
            if isLoadingDetail {
                ZStack {
                    Color.black.opacity(0.08).ignoresSafeArea()
                    ProgressView()
                }
            }
        }
        
        
    }

    private func loadReservationDetail(trackingCode: String) {
        Task {
            isLoadingDetail = true
            errorMessage = nil
            
            do {
                let reservation = try await reservationService.fetchReservation(by: trackingCode)
                fetchedReservation = reservation
                navigateToDetail = true
            } catch {
                errorMessage = languageManager.localized(
                    turkish: "Rezervasyon detayı alınamadı.",
                    english: "Booking detail could not be loaded."
                )
            }
            
            isLoadingDetail = false
        }
    }
    
    private func reservationCard(_ item: StoredReservation) -> some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(item.trackingCode)
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(AppColors.primary)
                    
                    Text("\(item.vehicleBrand) \(item.vehicleName)")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(AppColors.textPrimary)
                }
                
                Spacer()
                
                HStack( spacing: 10) {
                    Text(localizedStatus(item.status))
                        .font(.system(size: 13, weight: .semibold))
                        .foregroundColor(AppColors.primary)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(AppColors.primarySoft)
                        .clipShape(Capsule())
                    
                    Button {
                        LocalStorageManager.shared.removeReservation(trackingCode: item.trackingCode)
                        reservations = LocalStorageManager.shared.fetchReservations()
                    } label: {
                        Image(systemName: "trash")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.red)
                            .frame(width: 34, height: 34)
                            .background(Color.red.opacity(0.08))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
            }
            
            Text("\(languageManager.localized(turkish: "Alış", english: "Pick-up")): \(item.pickUpLocation)")
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(AppColors.textSecondary)
            
            Text("\(languageManager.localized(turkish: "Dönüş", english: "Return")): \(item.dropOffLocation)")
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(AppColors.textSecondary)
            
            Text("\(languageManager.fullDateString(from: item.pickUpDate)) - \(languageManager.fullDateString(from: item.dropOffDate))")
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(AppColors.textSecondary)
            
            Text(FormatterHelper.currencyString(item.totalAmount, code: item.currencyCode))
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(AppColors.textPrimary)
            
            Button {
                loadReservationDetail(trackingCode: item.trackingCode)
            } label: {
                Text(languageManager.localized(turkish: "Detayı Gör", english: "View Details"))
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 46)
                    .background(AppColors.primary)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
            }
            .padding(.top, 4)
        }
        .padding(18)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 22))
        .shadow(color: AppColors.shadow, radius: 10, x: 0, y: 6)
    }

    private func localizedStatus(_ status: String) -> String {
        switch status.trimmingCharacters(in: .whitespacesAndNewlines).lowercased() {
        case "yeni", "new":
            return languageManager.localized(turkish: "Yeni", english: "New")
        default:
            return status
        }
    }
    
}
