//
//  VehicleListView.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 8.04.2026.
//


import SwiftUI

struct VehicleListView: View {
    @StateObject private var viewModel: VehicleListViewModel
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var languageManager: AppLanguageManager
    
    @State private var selectedVehicle: Vehicle?
    @State private var navigateToExtras = false
    @State private var displayCurrency: PriceDisplayCurrency = .eur
    
    init(draft: ReservationDraft) {
        _viewModel = StateObject(
            wrappedValue: VehicleListViewModel(draft: draft)
        )
        _displayCurrency = State(initialValue: draft.displayCurrency)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            topBar
            
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {
                    headerSection
                    
                    VehicleFilterBar(viewModel: viewModel)
                    
                    contentSection
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                .padding(.bottom, 30)
            }
        }
        .background(AppColors.background.ignoresSafeArea())
        .navigationBarBackButtonHidden(true)
        .task {
            viewModel.onAppear()
        }
        .navigationDestination(isPresented: $navigateToExtras) {
            if let selectedVehicle {
                ExtraServicesView(
                    draft: viewModel.buildDraft(with: selectedVehicle)
                )
            }
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
            
            Text(languageManager.localized(turkish: "Araçlar", english: "Cars"))
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(AppColors.textPrimary)
                .lineLimit(1)
                .minimumScaleFactor(0.78)
            
            Spacer()
            
            HStack(spacing: 8) {
                LanguageToggleButton()
                currencyToggle
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 16)
    }

    private var currencyToggle: some View {
        Menu {
            ForEach(PriceDisplayCurrency.allCases) { currency in
                Button {
                    displayCurrency = currency
                } label: {
                    Label(
                        currency.title,
                        systemImage: displayCurrency == currency ? "checkmark.circle.fill" : "circle"
                    )
                }
            }
        } label: {
            RoundedRectangle(cornerRadius: 14)
                .fill(Color.white)
                .frame(width: 58, height: 46)
                .overlay(
                    HStack(spacing: 4) {
                        Text(displayCurrency.shortTitle)
                            .font(.system(size: 18, weight: .bold))
                        Image(systemName: "chevron.down")
                            .font(.system(size: 10, weight: .bold))
                    }
                    .foregroundColor(AppColors.primary)
                )
        }
    }
    
    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(languageManager.localized(
                turkish: "\(viewModel.vehicles.count) araç bulundu",
                english: "\(viewModel.vehicles.count) cars found"
            ))
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(AppColors.textPrimary)
            
            Text("\(viewModel.draft.pickUpLocation?.name ?? "") • \(languageManager.shortDateString(from: viewModel.draft.pickUpDate))")
                .font(.system(size: 15, weight: .medium))
                .foregroundColor(AppColors.textSecondary)
        }
    }
    
    @ViewBuilder
    private var contentSection: some View {
        if viewModel.isLoading {
            VStack(spacing: 16) {
                ProgressView()
                Text(languageManager.localized(turkish: "Araçlar yükleniyor...", english: "Loading cars..."))
                    .foregroundColor(AppColors.textSecondary)
            }
            .frame(maxWidth: .infinity)
            .padding(.top, 60)
        } else if let errorMessage = viewModel.errorMessage {
            VStack(spacing: 16) {
                Text(languageManager.localized(turkish: "Bir hata oluştu", english: "Something went wrong"))
                    .font(.title3.bold())
                
                Text(localizedVehicleError(errorMessage))
                    .multilineTextAlignment(.center)
                    .foregroundColor(AppColors.textSecondary)
                
                Button(languageManager.localized(turkish: "Tekrar Dene", english: "Try Again")) {
                    Task {
                        await viewModel.fetchVehicles()
                    }
                }
                .foregroundColor(.white)
                .padding(.horizontal, 18)
                .padding(.vertical, 12)
                .background(AppColors.primary)
                .clipShape(RoundedRectangle(cornerRadius: 14))
            }
            .frame(maxWidth: .infinity)
            .padding(.top, 60)
        } else if viewModel.vehicles.isEmpty {
            VStack(spacing: 10) {
                Text(languageManager.localized(turkish: "Araç bulunamadı", english: "No cars found"))
                    .font(.title3.bold())
                
                Text(languageManager.localized(
                    turkish: "Arama kriterlerinizi değiştirip tekrar deneyin.",
                    english: "Change your search criteria and try again."
                ))
                    .foregroundColor(AppColors.textSecondary)
            }
            .frame(maxWidth: .infinity)
            .padding(.top, 60)
        } else {
            LazyVStack(spacing: 18) {
                ForEach(viewModel.vehicles) { vehicle in
                    VehicleListCard(
                        vehicle: vehicle,
                        rentalDayCount: viewModel.rentalDayCount,
                        displayCurrency: displayCurrency,
                        selectAction: {
                            selectedVehicle = vehicle
                            viewModel.displayCurrency = displayCurrency
                            navigateToExtras = true
                        }
                    )
                }
            }
        }
    }

    private func localizedVehicleError(_ message: String) -> String {
        if message == "Araç arama bilgileri eksik." {
            return languageManager.localized(
                turkish: "Araç arama bilgileri eksik.",
                english: "Car search information is missing."
            )
        }

        return message
    }
}
