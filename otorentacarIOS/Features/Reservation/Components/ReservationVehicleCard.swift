//
//  ReservationVehicleCard.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 8.04.2026.
//


import SwiftUI

struct ReservationVehicleCard: View {
    let vehicle: Vehicle
    
    var body: some View {
        HStack(spacing: 16) {
            VStack(alignment: .leading, spacing: 8) {
                if let badge = vehicle.badge {
                    Text(badge)
                        .font(.system(size: 11, weight: .bold))
                        .foregroundColor(AppColors.textSecondary)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 6)
                        .background(AppColors.inputBackground)
                        .clipShape(Capsule())
                }
                
                Text("\(vehicle.brand) \(vehicle.name)")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(AppColors.textPrimary)
                
                Text("\(vehicle.transmission) | \(vehicle.fuelType)")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(AppColors.textSecondary)
            }
            
            Spacer()
            
            RoundedRectangle(cornerRadius: 18)
                .fill(.white)
                .frame(width: 150, height: 100)
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
                                    .padding(.horizontal, 4)
                                    .padding(.vertical, 8)

                            case .failure:
                                Image(systemName: "car.side.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100)
                                    .foregroundColor(.gray.opacity(0.75))

                            @unknown default:
                                EmptyView()
                            }
                        }
                    } else {
                        Image(systemName: "car.side.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100)
                            .foregroundColor(.gray.opacity(0.75))
                    }
                }
                .clipShape(RoundedRectangle(cornerRadius: 18))
        }
        .padding(18)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .shadow(color: AppColors.shadow, radius: 10, x: 0, y: 6)
    }
}
