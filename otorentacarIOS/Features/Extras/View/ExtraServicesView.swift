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
    @EnvironmentObject private var languageManager: AppLanguageManager

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
                currencyCode: viewModel.draft.currencyCode ?? viewModel.vehicle?.currencyCode,
                displayCurrency: viewModel.draft.displayCurrency
            ) {
                if viewModel.areChildrenAgesValid {
                    navigateToReservationDetail = true
                } else {
                    viewModel.errorMessage = languageManager.localized(
                        turkish: "Lütfen tüm bebek koltuğu yaş bilgilerini girin.",
                        english: "Please enter all child seat age information."
                    )
                }
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
        FormatterHelper.rentalDayCount(
            pickUpDate: viewModel.draft.pickUpDate,
            pickUpTime: viewModel.draft.pickUpTime,
            dropOffDate: viewModel.draft.dropOffDate,
            dropOffTime: viewModel.draft.dropOffTime
        )
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

            Text(languageManager.localized(turkish: "Ek Hizmetler", english: "Extras"))
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(AppColors.textPrimary)
                .lineLimit(1)
                .minimumScaleFactor(0.78)

            Spacer()

            LanguageToggleButton()
        }
        .padding(.horizontal, 20)
        .padding(.top, 16)
    }

    private var vehicleHeader: some View {
        HStack(spacing: 16) {
            RoundedRectangle(cornerRadius: 18)
                .fill(.white)
                .frame(width: 110, height: 88)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .overlay {
                    if let imageURL = viewModel.vehicle?.imageURL,
                       let url = URL(string: imageURL) {
                        AsyncImage(url: url) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)

                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    .padding(.horizontal, 4)
                                    .padding(.vertical, 8)

                            case .failure:
                                Image(systemName: "car.side.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 72)
                                    .foregroundColor(.gray.opacity(0.75))

                            @unknown default:
                                EmptyView()
                            }
                        }
                    } else {
                        Image(systemName: "car.side.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 72)
                            .foregroundColor(.gray.opacity(0.75))
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: 18))

            VStack(alignment: .leading, spacing: 6) {
                Text("\((viewModel.vehicle?.brand ?? "")) \((viewModel.vehicle?.name ?? ""))")
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(AppColors.textPrimary)

                Text(viewModel.vehicle?.segment ?? "")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(AppColors.textSecondary)

                Text(languageManager.localized(turkish: "\(dayCount) gün kiralama", english: "\(dayCount) day rental"))
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(AppColors.primary)
            }

            Spacer()
        }
    }

    private var titleSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(languageManager.localized(turkish: "Yolculuğunu Güçlendir", english: "Upgrade Your Trip"))
                .font(.system(size: 28, weight: .bold))
                .foregroundColor(AppColors.textPrimary)

            Text(languageManager.localized(
                turkish: "İhtiyacına uygun ek hizmetleri seçebilirsin.",
                english: "Choose the extras that fit your trip."
            ))
                .font(.system(size: 15, weight: .medium))
                .foregroundColor(AppColors.textSecondary)
        }
    }

    @ViewBuilder
    private var contentSection: some View {
        if viewModel.isLoading {
            VStack(spacing: 16) {
                ProgressView()
                Text(languageManager.localized(turkish: "Ek hizmetler yükleniyor...", english: "Loading extras..."))
                    .foregroundColor(AppColors.textSecondary)
            }
            .frame(maxWidth: .infinity)
            .padding(.top, 50)
        } else if let errorMessage = viewModel.errorMessage {
            VStack(spacing: 16) {
                Text(languageManager.localized(turkish: "Bir hata oluştu", english: "Something went wrong"))
                    .font(.title3.bold())

                Text(errorMessage)
                    .multilineTextAlignment(.center)
                    .foregroundColor(AppColors.textSecondary)

                Button(languageManager.localized(turkish: "Tekrar Dene", english: "Try Again")) {
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
                        currencyCode: viewModel.draft.currencyCode ?? viewModel.vehicle?.currencyCode,
                        displayCurrency: viewModel.draft.displayCurrency,
                        childrenAges: item.title.lowercased().contains("bebek koltuğu") ? viewModel.childrenAges : [],
                        onChildAgeChange: item.title.lowercased().contains("bebek koltuğu")
                            ? { index, value in
                                viewModel.updateChildAge(value, at: index)
                            }
                            : nil
                    )
                }
            }
        }
    }
    
    private var childrenAgesSection: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text(languageManager.localized(turkish: "Bebek Koltuğu Yaş Bilgileri", english: "Child Seat Age Details"))
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(AppColors.textPrimary)

            Text(languageManager.localized(
                turkish: "Seçilen her bebek koltuğu için yaş bilgisi girin.",
                english: "Enter age information for each selected child seat."
            ))
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(AppColors.textSecondary)

            ForEach(Array(viewModel.childrenAges.enumerated()), id: \.offset) { index, value in
                VStack(alignment: .leading, spacing: 8) {
                    Text(languageManager.localized(
                        turkish: "\(index + 1). Bebek Koltuğu Yaşı",
                        english: "Child Seat \(index + 1) Age"
                    ))
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(AppColors.textSecondary)

                    TextField(languageManager.localized(turkish: "Örn: 2", english: "Ex: 2"), text: Binding(
                        get: { value },
                        set: { viewModel.updateChildAge($0, at: index) }
                    ))
                    .keyboardType(.numberPad)
                    .padding()
                    .frame(height: 58)
                    .background(AppColors.inputBackground)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .foregroundStyle(.black)
                }
            }
        }
    }
}
