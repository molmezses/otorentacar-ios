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
    @EnvironmentObject private var languageManager: AppLanguageManager
    
    
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
                        title: languageManager.localized(turkish: "Alış", english: "Pick-up"),
                        location: viewModel.draft.pickUpLocation?.name ?? "",
                        date: viewModel.draft.pickUpDate,
                        time: FormatterHelper.timeString.string(from: viewModel.draft.pickUpTime)
                    )

                    ReservationLocationCard(
                        title: languageManager.localized(turkish: "Dönüş", english: "Return"),
                        location: viewModel.draft.dropOffLocation?.name ?? viewModel.draft.pickUpLocation?.name ?? "",
                        date: viewModel.draft.dropOffDate,
                        time: FormatterHelper.timeString.string(from: viewModel.draft.dropOffTime)
                    )
                }
                
                PersonalInfoFormSection(viewModel: viewModel)
                
                PaymentSummaryCard(
                    vehicleRentalTotal: viewModel.vehicleRentalTotal,
                    extrasTotal: viewModel.extrasTotal,
                    grandTotal: viewModel.grandTotal,
                    currencyCode: viewModel.draft.currencyCode ?? viewModel.selectedVehicle?.currencyCode,
                    displayCurrency: viewModel.draft.displayCurrency,
                    rentalDayCount: viewModel.rentalDayCount
                )
                
                if !viewModel.selectedExtras.isEmpty {
                    ReservationExtrasCard(
                        extras: viewModel.selectedExtras,
                        currencyCode: viewModel.draft.currencyCode ?? viewModel.selectedVehicle?.currencyCode,
                        displayCurrency: viewModel.draft.displayCurrency,
                        rentalDayCount: viewModel.rentalDayCount
                    )
                }
                
                if let errorMessage = viewModel.errorMessage, !viewModel.isReadOnly {
                    Text(errorMessage)
                        .font(.system(size: 15, weight: .medium))
                        .foregroundColor(.red)
                        .padding(.horizontal, 4)
                }
                
                if !viewModel.isReadOnly {
                    ORPrimaryButton(
                        title: viewModel.actionButtonTitle(language: languageManager.language),
                        icon: "arrow.right"
                    ) {
                        Task {
                            await viewModel.submitReservation(language: languageManager.language)
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
        .navigationDestination(isPresented: $viewModel.navigateToSuccess) {
            ReservationSuccessView(
                reservationCode: viewModel.reservationCode,
                storedReservation: viewModel.makeStoredReservation()
            )
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
            
            Text(viewModel.screenTitle(language: languageManager.language))
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(AppColors.textPrimary)
                .lineLimit(1)
                .minimumScaleFactor(0.78)
            
            Spacer()
            
            LanguageToggleButton()
        }
    }
    
    private var titleSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(viewModel.heroTitle(language: languageManager.language))
                .font(.system(size: 30, weight: .bold))
                .foregroundColor(AppColors.textPrimary)
            
            Text(viewModel.heroSubtitle(language: languageManager.language))
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(AppColors.textSecondary)
        }
    }
}
