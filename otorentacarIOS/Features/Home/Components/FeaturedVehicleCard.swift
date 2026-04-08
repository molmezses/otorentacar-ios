//
//  FeaturedVehicleCard.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 8.04.2026.
//

import SwiftUI

struct FeaturedVehicleCard: View {
    let vehicle: Vehicle
    
    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 6) {
                    Text("\(vehicle.brand) \(vehicle.name)")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(AppColors.textPrimary)
                    
                    Text(vehicle.segment.uppercased())
                        .font(.system(size: 12, weight: .medium))
                        .foregroundColor(AppColors.textSecondary)
                }
                
                Spacer()
                
                Button {} label: {
                    RoundedRectangle(cornerRadius: 14)
                        .fill(AppColors.inputBackground)
                        .frame(width: 48, height: 48)
                        .overlay(
                            Image(systemName: vehicle.isFavorite ? "heart.fill" : "heart")
                                .foregroundColor(AppColors.primary)
                        )
                }
            }
            
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.gray.opacity(0.15))
                .frame(height: 170)
                .overlay(
                    Image(systemName: "car.side.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 140)
                        .foregroundColor(.gray.opacity(0.7))
                )
            
            HStack(spacing: 14) {
                Label(vehicle.transmission, systemImage: "gearshape.fill")
                Label(vehicle.fuelType, systemImage: "fuelpump.fill")
                
                Spacer()
                
                VStack(alignment: .trailing, spacing: 4) {
                    Text("Günlük")
                        .font(.system(size: 14))
                        .foregroundColor(AppColors.textSecondary)
                    
                    Text(FormatterHelper.currency.string(from: NSNumber(value: vehicle.dailyPrice)) ?? "₺0")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(AppColors.primary)
                }
            }
            .font(.system(size: 14, weight: .medium))
            .foregroundColor(AppColors.textSecondary)
        }
        .padding(18)
        .frame(width: 300)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 28))
    }
}
