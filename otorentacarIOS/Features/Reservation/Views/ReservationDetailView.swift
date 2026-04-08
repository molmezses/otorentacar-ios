//
//  ReservationDetailView.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 8.04.2026.
//


import SwiftUI

struct ReservationDetailView: View {
    @StateObject private var viewModel: ReservationDetailViewModel
    @Environment(\.dismiss) private var dismiss
    
    init(draft: ReservationDraft) {
        _viewModel = StateObject(
            wrappedValue: ReservationDetailViewModel(draft: draft)
        )
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 24) {
                topBar
                
                titleSection
                
                ReservationVehicleCard(vehicle: viewModel.draft.vehicle)
                
                HStack(spacing: 14) {
                    ReservationLocationCard(
                        title: "Alış",
                        location: viewModel.draft.searchRequest.pickUpLocation,
                        date: viewModel.draft.searchRequest.pickUpDate,
                        time: viewModel.draft.searchRequest.pickUpTime
                    )
                    
                    ReservationLocationCard(
                        title: "Dönüş",
                        location: viewModel.draft.searchRequest.dropOffLocation ?? viewModel.draft.searchRequest.pickUpLocation,
                        date: viewModel.draft.searchRequest.dropOffDate,
                        time: viewModel.draft.searchRequest.dropOffTime
                    )
                }
                
                PersonalInfoFormSection(viewModel: viewModel)
                
                PaymentSummaryCard(
                    vehicleRentalTotal: viewModel.vehicleRentalTotal,
                    extrasTotal: viewModel.extrasTotal,
                    taxAmount: viewModel.taxAmount,
                    grandTotal: viewModel.grandTotal
                )
                
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                        .font(.system(size: 15, weight: .medium))
                        .foregroundColor(.red)
                        .padding(.horizontal, 4)
                }
                
                ORPrimaryButton(
                    title: viewModel.isSubmitting ? "İşleniyor..." : "Rezervasyonu Tamamla",
                    icon: "arrow.right"
                ) {
                    Task {
                        await viewModel.submitReservation()
                    }
                }
                .disabled(viewModel.isSubmitting)
                .opacity(viewModel.isSubmitting ? 0.7 : 1)
            }
            .padding(.horizontal, 20)
            .padding(.top, 16)
            .padding(.bottom, 28)
        }
        .background(AppColors.background.ignoresSafeArea())
        .navigationBarBackButtonHidden(true)
        .alert("Başarılı", isPresented: $viewModel.showSuccessMessage) {
            Button("Tamam") { }
        } message: {
            Text("Rezervasyon başarıyla oluşturuldu.")
        }
    }
    
    private var topBar: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                RoundedRectangle(cornerRadius: 14)
                    .fill(Color.white)
                    .frame(width: 46, height: 46)
                    .overlay(
                        Image(systemName: "chevron.left")
                            .foregroundColor(AppColors.textPrimary)
                            .font(.system(size: 18, weight: .semibold))
                    )
            }
            
            Spacer()
            
            Text("Rezervasyon Detayı")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(AppColors.textPrimary)
            
            Spacer()
            
            RoundedRectangle(cornerRadius: 14)
                .fill(Color.clear)
                .frame(width: 46, height: 46)
        }
    }
    
    private var titleSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Rezervasyon Detayları")
                .font(.system(size: 30, weight: .bold))
                .foregroundColor(AppColors.textPrimary)
            
            Text("Bilgilerini doldurup rezervasyonu tamamlayabilirsin.")
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(AppColors.textSecondary)
        }
    }
}