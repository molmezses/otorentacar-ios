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
    
    @State private var selectedVehicle: Vehicle?
    @State private var navigateToExtras = false
    
    init(draft: ReservationDraft) {
        _viewModel = StateObject(
            wrappedValue: VehicleListViewModel(draft: draft)
        )
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
            
            Text("Araçlar")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(AppColors.textPrimary)
            
            Spacer()
            
            RoundedRectangle(cornerRadius: 14)
                .fill(Color.clear)
                .frame(width: 46, height: 46)
        }
        .padding(.horizontal, 20)
        .padding(.top, 16)
    }
    
    private var headerSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("\(viewModel.vehicles.count) araç bulundu")
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(AppColors.textPrimary)
            
            Text("\(viewModel.draft.pickUpLocation?.name ?? "") • \(FormatterHelper.shortDate.string(from: viewModel.draft.pickUpDate))")
                .font(.system(size: 15, weight: .medium))
                .foregroundColor(AppColors.textSecondary)
        }
    }
    
    @ViewBuilder
    private var contentSection: some View {
        if viewModel.isLoading {
            VStack(spacing: 16) {
                ProgressView()
                Text("Araçlar yükleniyor...")
                    .foregroundColor(AppColors.textSecondary)
            }
            .frame(maxWidth: .infinity)
            .padding(.top, 60)
        } else if let errorMessage = viewModel.errorMessage {
            VStack(spacing: 16) {
                Text("Bir hata oluştu")
                    .font(.title3.bold())
                
                Text(errorMessage)
                    .multilineTextAlignment(.center)
                    .foregroundColor(AppColors.textSecondary)
                
                Button("Tekrar Dene") {
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
                Text("Araç bulunamadı")
                    .font(.title3.bold())
                
                Text("Arama kriterlerinizi değiştirip tekrar deneyin.")
                    .foregroundColor(AppColors.textSecondary)
            }
            .frame(maxWidth: .infinity)
            .padding(.top, 60)
        } else {
            LazyVStack(spacing: 18) {
                ForEach(viewModel.vehicles) { vehicle in
                    VehicleListCard(vehicle: vehicle) {
                        selectedVehicle = vehicle
                        navigateToExtras = true
                    }
                }
            }
        }
    }
}
