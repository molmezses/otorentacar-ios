//
//  FavoritesView.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 23.04.2026.
//


import SwiftUI

struct FavoritesView: View {
    @State private var favorites: [Vehicle] = []

    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 20) {
                Text("Favorilerim")
                    .font(.system(size: 30, weight: .bold))
                    .foregroundColor(AppColors.textPrimary)

                if favorites.isEmpty {
                    VStack(spacing: 14) {
                        Image(systemName: "heart")
                            .font(.system(size: 42))
                            .foregroundColor(AppColors.primary)

                        Text("Henüz favori aracınız yok")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundColor(AppColors.textPrimary)

                        Text("Beğendiğiniz araçları favorilere ekleyerek daha sonra hızlıca görüntüleyebilirsiniz.")
                            .font(.system(size: 15, weight: .medium))
                            .foregroundColor(AppColors.textSecondary)
                            .multilineTextAlignment(.center)
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.top, 80)
                } else {
                    LazyVStack(spacing: 16) {
                        ForEach(favorites) { vehicle in
                            favoriteCard(vehicle)
                        }
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 20)
            .padding(.bottom, 24)
        }
        .background(AppColors.background.ignoresSafeArea())
        .onAppear {
            favorites = LocalStorageManager.shared.fetchFavorites()
        }
    }

    private func favoriteCard(_ vehicle: Vehicle) -> some View {
        HStack(spacing: 14) {
            RoundedRectangle(cornerRadius: 16)
                .fill(AppColors.inputBackground)
                .frame(width: 96, height: 76)
                .overlay {
                    if let imageURL = vehicle.imageURL,
                       let url = URL(string: imageURL) {
                        AsyncImage(url: url) { phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                            case .success(let image):
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .padding(6)
                            default:
                                Image(systemName: "car.side.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 54)
                                    .foregroundColor(.gray.opacity(0.7))
                            }
                        }
                    } else {
                        Image(systemName: "car.side.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 54)
                            .foregroundColor(.gray.opacity(0.7))
                    }
                }

            VStack(alignment: .leading, spacing: 6) {
                Text("\(vehicle.brand) \(vehicle.name)")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(AppColors.textPrimary)

                Text(vehicle.segment)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(AppColors.textSecondary)

                Text(FormatterHelper.currencyString(vehicle.dailyPrice, code: vehicle.currencyCode))
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(AppColors.primary)
            }

            Spacer()

            Button {
                LocalStorageManager.shared.removeFavorite(vehicleId: vehicle.id)
                favorites = LocalStorageManager.shared.fetchFavorites()
            } label: {
                RoundedRectangle(cornerRadius: 14)
                    .fill(AppColors.primarySoft)
                    .frame(width: 44, height: 44)
                    .overlay(
                        Image(systemName: "heart.fill")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundColor(AppColors.primary)
                    )
            }
        }
        .padding(16)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 22))
        .shadow(color: AppColors.shadow, radius: 10, x: 0, y: 6)
    }
}
