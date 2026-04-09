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
            
            HStack(alignment: .bottom) {
                HStack(spacing: 6) {
                    vehicleSpecBadge(icon: "gearshape.fill", title: vehicle.transmission)
                    vehicleSpecBadge(icon: "fuelpump.fill", title: vehicle.fuelType)
                }
                
                Spacer(minLength: 12)
                
                VStack(alignment: .trailing, spacing: 4) {
                    Text("Günlük")
                        .font(.system(size: 13, weight: .medium))
                        .foregroundColor(AppColors.textSecondary)
                    
                    Text(FormatterHelper.currency.string(from: NSNumber(value: vehicle.dailyPrice)) ?? "₺0")
                        .font(.system(size: 20, weight: .bold))
                        .foregroundColor(AppColors.primary)
                        .lineLimit(1)
                }
            }
        }
        .padding(18)
        .frame(width: 300)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 28))
    }
}

@ViewBuilder
private func vehicleSpecBadge(icon: String, title: String) -> some View {
    HStack(spacing: 4) {
        Image(systemName: icon)
            .font(.system(size: 11, weight: .semibold))
            .foregroundColor(AppColors.primary)
        
        Text(formattedSpecTitle(title))
            .font(.system(size: 12, weight: .semibold))
            .foregroundColor(AppColors.primaryDark)
            .fixedSize(horizontal: true, vertical: false)
    }
    .padding(.horizontal, 8)
    .frame(height: 28)
    .background(AppColors.primarySoft)
    .clipShape(Capsule())
}

private func formattedSpecTitle(_ value: String) -> String {
    let cleaned = value.trimmingCharacters(in: .whitespacesAndNewlines)
    let lowercased = cleaned.lowercased()
    
    switch lowercased {
    case "automatic", "auto", "otomatik":
        return "Auto"
    case "manual", "manuel":
        return "Manuel"
    case "diesel", "dizel":
        return "Dizel"
    case "gasoline", "petrol", "benzin", "benzinli":
        return "Benzin"
    case "hybrid", "hibrit":
        return "Hybrid"
    case "electric", "elektrik", "elektrikli":
        return "Elektrik"
    default:
        if let firstWord = cleaned.split(separator: " ").first {
            let short = String(firstWord)
            return short.count > 8 ? String(short.prefix(8)) : short
        }
        return cleaned.count > 8 ? String(cleaned.prefix(8)) : cleaned
    }
}

private func normalizedSpecText(_ value: String) -> String {
    let cleaned = value.trimmingCharacters(in: .whitespacesAndNewlines)
    
    if cleaned.count <= 10 {
        return cleaned
    }
    
    let words = cleaned.split(separator: " ")
    if let first = words.first {
        let firstWord = String(first)
        return firstWord.count <= 10 ? firstWord : String(firstWord.prefix(10))
    }
    
    return String(cleaned.prefix(10))
}
