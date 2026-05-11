//
//  HomeView.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 8.04.2026.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var languageManager: AppLanguageManager
    @StateObject private var viewModel = HomeViewModel()
    @State private var navigateToVehicleList = false
    @State private var reservationDraft: ReservationDraft?
    var onMenuTap: () -> Void
    
    var body: some View {
        NavigationStack {
            GeometryReader { proxy in
                let contentWidth = max(proxy.size.width - 32, 0)

                ZStack(alignment: .bottomTrailing) {
                    ScrollView(showsIndicators: false) {
                        VStack(alignment: .leading, spacing: 24) {
                            ORTopBar(
                                onMenuTap: onMenuTap
                            )
                            .frame(width: contentWidth)

                            VStack(alignment: .leading, spacing: 8) {
                                Text(languageManager.localized(
                                    turkish: "Mükemmel Sürüşünüzü",
                                    english: "Discover Your"
                                ))
                                .font(.system(size: 28, weight: .bold))
                                .foregroundColor(AppColors.textPrimary)
                                .lineLimit(1)
                                .minimumScaleFactor(0.78)

                                Text(languageManager.localized(
                                    turkish: "Bugün Keşfedin.",
                                    english: "Perfect Drive Today."
                                ))
                                .font(.system(size: 28, weight: .bold))
                                .foregroundColor(AppColors.primary)
                                .lineLimit(1)
                                .minimumScaleFactor(0.78)
                            }
                            .frame(width: contentWidth, alignment: .leading)

                            SearchFormCard(viewModel: viewModel) {
                                if viewModel.validateSearchForm(language: languageManager.language),
                                   let draft = viewModel.buildReservationDraft() {
                                    reservationDraft = draft
                                    navigateToVehicleList = true
                                }
                            }
                            .frame(width: contentWidth)

                            HomePromoBanner(language: languageManager.language)
                                .frame(width: contentWidth)
                        }
                        .frame(width: contentWidth, alignment: .leading)
                        .padding(.horizontal, 16)
                        .padding(.top, 20)
                        .padding(.bottom, 104)
                    }

                    WhatsAppFloatingButton(
                        phoneNumber: AppConstants.whatsappNumber,
                        message: "Merhaba, araç kiralama hakkında bilgi almak istiyorum."
                    )
                    .padding(.trailing, 22)
                    .padding(.bottom, 22)
                }
                .frame(width: proxy.size.width, height: proxy.size.height)
                .clipped()
            }
            .background(AppColors.background)
            .task {
                viewModel.onAppear()
            }
            .onReceive(NotificationCenter.default.publisher(for: .resetBookingFlow)) { _ in
                viewModel.resetForm()
                reservationDraft = nil
                navigateToVehicleList = false
            }
            .navigationDestination(isPresented: $navigateToVehicleList) {
                if let reservationDraft {
                    VehicleListView(draft: reservationDraft)
                }
            }
            .alert(
                languageManager.localized(turkish: "Uyarı", english: "Warning"),
                isPresented: $viewModel.showSearchErrorAlert
            ) {
                Button(languageManager.localized(turkish: "Tamam", english: "OK"), role: .cancel) { }
            } message: {
                Text(viewModel.searchErrorMessage)
            }
        }
    }
}
