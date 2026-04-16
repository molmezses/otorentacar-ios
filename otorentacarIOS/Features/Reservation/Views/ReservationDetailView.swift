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
    
    private let reservationService: AddReservationServiceProtocol = AddReservationAPIService()
    
    init(draft: ReservationDraft, mode: ReservationDetailMode = .create) {
        _viewModel = StateObject(
            wrappedValue: ReservationDetailViewModel(draft: draft, mode: mode)
        )
    }
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 24) {
                topBar
                
                titleSection
                
                if let trackingCode = viewModel.trackingCodeText,
                   let status = viewModel.reservationStatusText {
                    ReservationInfoBanner(
                        trackingCode: trackingCode,
                        status: status
                    )
                }
                
                if let vehicle = viewModel.selectedVehicle {
                    ReservationVehicleCard(vehicle: vehicle)
                }
                
                HStack(spacing: 14) {
                    ReservationLocationCard(
                        title: "Alış",
                        location: viewModel.draft.pickUpLocation?.name ?? "",
                        date: viewModel.draft.pickUpDate,
                        time: FormatterHelper.timeString.string(from: viewModel.draft.pickUpTime)
                    )

                    ReservationLocationCard(
                        title: "Dönüş",
                        location: viewModel.draft.dropOffLocation?.name ?? viewModel.draft.pickUpLocation?.name ?? "",
                        date: viewModel.draft.dropOffDate,
                        time: FormatterHelper.timeString.string(from: viewModel.draft.dropOffTime)
                    )
                }
                
                PersonalInfoFormSection(viewModel: viewModel)
                
                PaymentSummaryCard(
                    vehicleRentalTotal: viewModel.vehicleRentalTotal,
                    extrasTotal: viewModel.extrasTotal,
                    grandTotal: viewModel.grandTotal
                )
                
                if let errorMessage = viewModel.errorMessage, !viewModel.isReadOnly {
                    Text(errorMessage)
                        .font(.system(size: 15, weight: .medium))
                        .foregroundColor(.red)
                        .padding(.horizontal, 4)
                }
                
                if !viewModel.isReadOnly {
                    ORPrimaryButton(
                        title: viewModel.actionButtonTitle,
                        icon: "arrow.right"
                    ) {
                        Task {
                            await viewModel.submitReservation()
                        }
                    }
                    .disabled(viewModel.isSubmitting)
                    .opacity(viewModel.isSubmitting ? 0.7 : 1)
                }
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
            
            Text(viewModel.screenTitle)
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
            Text(viewModel.heroTitle)
                .font(.system(size: 30, weight: .bold))
                .foregroundColor(AppColors.textPrimary)
            
            Text(viewModel.heroSubtitle)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(AppColors.textSecondary)
        }
    }
}
