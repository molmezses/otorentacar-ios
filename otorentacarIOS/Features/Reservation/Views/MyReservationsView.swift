//
//  MyReservationsView.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 23.04.2026.
//


import SwiftUI

struct MyReservationsView: View {
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
                Text("Rezervasyonlarım")
                    .font(.system(size: 30, weight: .bold))
                    .foregroundColor(AppColors.textPrimary)
                
                if reservations.isEmpty {
                    VStack(spacing: 14) {
                        Image(systemName: "calendar.badge.exclamationmark")
                            .font(.system(size: 42))
                            .foregroundColor(AppColors.primary)
                        
                        Text("Henüz kayıtlı rezervasyonunuz yok")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(AppColors.textPrimary)
                        
                        Text("Yeni bir rezervasyon oluşturduğunuzda burada görüntüleyebilirsiniz.")
                            .font(.system(size: 15, weight: .medium))
                            .foregroundColor(AppColors.textSecondary)
                            .multilineTextAlignment(.center)
                        
                        Button {
                            onCreateReservationTap?()
                        } label: {
                            Text("Rezervasyon Oluştur")
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
                errorMessage = "Rezervasyon detayı alınamadı."
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
                    Text(item.status)
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
            
            Text("Alış: \(item.pickUpLocation)")
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(AppColors.textSecondary)
            
            Text("Dönüş: \(item.dropOffLocation)")
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(AppColors.textSecondary)
            
            Text("\(FormatterHelper.fullDate.string(from: item.pickUpDate)) - \(FormatterHelper.fullDate.string(from: item.dropOffDate))")
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(AppColors.textSecondary)
            
            Text(FormatterHelper.currencyString(item.totalAmount, code: item.currencyCode))
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(AppColors.textPrimary)
            
            Button {
                loadReservationDetail(trackingCode: item.trackingCode)
            } label: {
                Text("Detayı Gör")
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
    
}
