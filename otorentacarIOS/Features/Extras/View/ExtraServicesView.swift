//
//  ExtraServicesView.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 8.04.2026.
//


import SwiftUI

struct ExtraServicesView: View {
    @StateObject private var viewModel: ExtraServicesViewModel
    @Environment(\.dismiss) private var dismiss

    @State private var navigateToReservationDetail = false

    init(draft: ReservationDraft) {
        _viewModel = StateObject(
            wrappedValue: ExtraServicesViewModel(draft: draft)
        )
    }

    var body: some View {
        VStack(spacing: 0) {
            topBar

            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {
                    vehicleHeader
                    titleSection
                    contentSection
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                .padding(.bottom, 24)
            }

            ExtraSummaryBar(
                vehicleTotal: viewModel.vehicle?.totalPrice ?? 0,
                extrasTotal: viewModel.selectedExtras.reduce(0) { partial, item in
                    partial + (item.pricePerDay * Double(max(item.quantity, 1)) * Double(dayCount))
                },
                grandTotal: (viewModel.vehicle?.totalPrice ?? 0) + viewModel.selectedExtras.reduce(0) { partial, item in
                    partial + (item.pricePerDay * Double(max(item.quantity, 1)) * Double(dayCount))
                },
                currencyCode: viewModel.draft.currencyCode ?? viewModel.vehicle?.currencyCode
            ) {
                navigateToReservationDetail = true
            }
            .padding(.horizontal, 12)
            .padding(.bottom, 8)
            .background(AppColors.background)
        }
        .background(AppColors.background.ignoresSafeArea())
        .navigationBarBackButtonHidden(true)
        .task {
            viewModel.onAppear()
        }
        .navigationDestination(isPresented: $navigateToReservationDetail) {
            ReservationDetailView(
                draft: viewModel.buildDraftForReservationDetail()
            )
        }
    }

    private var dayCount: Int {
        let calendar = Calendar.current
        let start = calendar.startOfDay(for: viewModel.draft.pickUpDate)
        let end = calendar.startOfDay(for: viewModel.draft.dropOffDate)
        let days = calendar.dateComponents([.day], from: start, to: end).day ?? 1
        return max(days, 1)
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

            Text("Ek Hizmetler")
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

    private var vehicleHeader: some View {
        HStack(spacing: 16) {
            RoundedRectangle(cornerRadius: 18)
                .fill(Color.white)
                .frame(width: 110, height: 88)
                .overlay(
                    Image(systemName: "car.side.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 72)
                        .foregroundColor(.gray.opacity(0.75))
                )

            VStack(alignment: .leading, spacing: 6) {
                Text("\((viewModel.vehicle?.brand ?? "")) \((viewModel.vehicle?.name ?? ""))")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(AppColors.textPrimary)

                Text(viewModel.vehicle?.segment ?? "")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(AppColors.textSecondary)

                Text("\(dayCount) gün kiralama")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(AppColors.primary)
            }

            Spacer()
        }
    }

    private var titleSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Yolculuğunu Güçlendir")
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(AppColors.textPrimary)

            Text("İhtiyacına uygun ek hizmetleri seçebilirsin.")
                .font(.system(size: 15, weight: .medium))
                .foregroundColor(AppColors.textSecondary)
        }
    }

    @ViewBuilder
    private var contentSection: some View {
        if viewModel.isLoading {
            VStack(spacing: 16) {
                ProgressView()
                Text("Ek hizmetler yükleniyor...")
                    .foregroundColor(AppColors.textSecondary)
            }
            .frame(maxWidth: .infinity)
            .padding(.top, 50)
        } else if let errorMessage = viewModel.errorMessage {
            VStack(spacing: 16) {
                Text("Bir hata oluştu")
                    .font(.title3.bold())

                Text(errorMessage)
                    .multilineTextAlignment(.center)
                    .foregroundColor(AppColors.textSecondary)

                Button("Tekrar Dene") {
                    Task {
                        await viewModel.loadExtras()
                    }
                }
                .foregroundColor(.white)
                .padding(.horizontal, 18)
                .padding(.vertical, 12)
                .background(AppColors.primary)
                .clipShape(RoundedRectangle(cornerRadius: 14))
            }
            .frame(maxWidth: .infinity)
            .padding(.top, 50)
        } else {
            LazyVStack(spacing: 16) {
                ForEach(viewModel.services) { item in
                    ExtraServiceCard(
                        item: item,
                        dayCount: dayCount,
                        onToggle: {
                            viewModel.updateToggle(for: item.id, isOn: !item.isSelected)
                        },
                        onIncrease: {
                            viewModel.increaseQuantity(for: item.id)
                        },
                        onDecrease: {
                            viewModel.decreaseQuantity(for: item.id)
                        },
                        currencyCode: viewModel.draft.currencyCode ?? viewModel.vehicle?.currencyCode
                    )
                }
            }
        }
    }
}
