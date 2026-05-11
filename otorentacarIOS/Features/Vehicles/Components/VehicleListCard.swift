//
//  VehicleListCard.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 8.04.2026.
//


import SwiftUI

struct VehicleListCard: View {
    @EnvironmentObject private var languageManager: AppLanguageManager

    let vehicle: Vehicle
    let rentalDayCount: Int
    let displayCurrency: PriceDisplayCurrency

    var selectAction: (() -> Void)? = nil

    @State private var isFavorite: Bool

    init(
        vehicle: Vehicle,
        rentalDayCount: Int = 1,
        displayCurrency: PriceDisplayCurrency = .eur,
        selectAction: (() -> Void)? = nil
    ) {

        self.vehicle = vehicle
        self.rentalDayCount = rentalDayCount
        self.displayCurrency = displayCurrency

        self.selectAction = selectAction

        _isFavorite = State(initialValue: LocalStorageManager.shared.isFavorite(vehicleId: vehicle.id))

    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 6) {
                    if let badge = vehicle.badge {
                        Text(badge)
                            .font(.system(size: 11, weight: .bold))
                            .foregroundColor(AppColors.primary)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 6)
                            .background(AppColors.primarySoft)
                            .clipShape(Capsule())
                    }
                    
                    Text("\(vehicle.brand) \(vehicle.name)")
                        .font(.system(size: 22, weight: .bold))
                        .foregroundColor(AppColors.textPrimary)
                    
                    Text(vehicle.segment)
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(AppColors.textSecondary)
                }
                
                Spacer()
                
                Button {
                    isFavorite.toggle()

                    if isFavorite {
                        LocalStorageManager.shared.saveFavorite(vehicle)
                    } else {
                        LocalStorageManager.shared.removeFavorite(vehicleId: vehicle.id)
                    }
                } label: {
                    RoundedRectangle(cornerRadius: 14)
                        .fill(isFavorite ? AppColors.primarySoft : AppColors.inputBackground)
                        .frame(width: 46, height: 46)
                        .overlay(
                            Image(systemName: isFavorite ? "heart.fill" : "heart")
                                .font(.system(size: 18, weight: .medium))
                                .foregroundColor(isFavorite ? AppColors.primary : AppColors.textSecondary)
                        )
                }
            }
            
            RoundedRectangle(cornerRadius: 18)
                .fill(.white)
                .frame(height: 180)
                .overlay {
                    if let imageURL = vehicle.imageURL,
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
                                    .padding(.horizontal, 6)
                                    .padding(.vertical, 10)

                            case .failure:
                                Image(systemName: "car.side.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 170)
                                    .foregroundColor(.gray.opacity(0.75))

                            @unknown default:
                                EmptyView()
                            }
                        }
                    } else {
                        Image(systemName: "car.side.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 170)
                            .foregroundColor(.gray.opacity(0.75))
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: 18))
            
            HStack(spacing: 20) {
                vehicleInfoItem(icon: "gearshape.fill", value: languageManager.localizedVehicleSpec(vehicle.transmission))
                vehicleInfoItem(icon: "fuelpump.fill", value: languageManager.localizedVehicleSpec(vehicle.fuelType))
                vehicleInfoItem(icon: "person.2.fill", value: "\(vehicle.passengerCount)")
                vehicleInfoItem(icon: "suitcase.fill", value: "\(vehicle.baggageCount)")
            }
            .font(.system(size: 13, weight: .medium))
            .foregroundColor(AppColors.textSecondary)
            
            HStack(alignment: .bottom) {
                VStack(alignment: .leading, spacing: 4) {
                    Text(languageManager.localized(turkish: "Günlük", english: "Daily"))
                        .font(.system(size: 13, weight: .medium))
                        .foregroundColor(AppColors.textSecondary)
                    
                    Text(FormatterHelper.displayCurrencyString(
                        vehicle.dailyPrice,
                        originalCode: vehicle.currencyCode,
                        displayCurrency: displayCurrency
                    ))
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(AppColors.primary)
                    
                    Text(languageManager.localized(
                        turkish: "\(rentalDayCount) gün toplam ",
                        english: "\(rentalDayCount) days total "
                    ) + FormatterHelper.displayCurrencyString(
                        vehicle.totalPrice,
                        originalCode: vehicle.currencyCode,
                        displayCurrency: displayCurrency
                    ))
                        .font(.system(size: 13, weight: .medium))
                        .foregroundColor(AppColors.textSecondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Spacer()
                
                Button(action: {
                    selectAction?()
                }) {
                    Text(languageManager.localized(turkish: "Seç", english: "Select"))
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.white)
                        .frame(width: 120, height: 50)
                        .background(AppColors.primary)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                }
            }
        }
        .padding(18)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 28))
        .shadow(color: AppColors.shadow, radius: 12, x: 0, y: 6)
    }
    
    private func vehicleInfoItem(icon: String, value: String) -> some View {
        HStack(spacing: 6) {
            Image(systemName: icon)
            Text(value)
        }
    }
}
