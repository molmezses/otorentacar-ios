//
//  ORLocationPickerField.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 13.04.2026.
//


import SwiftUI

struct ORLocationPickerField: View {
    let title: String
    let placeholder: String
    let locations: [LocationDTO]
    @Binding var selectedLocation: LocationDTO?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title.uppercased())
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(AppColors.textSecondary)
            
            Menu {
                ForEach(locations, id: \.id) { location in
                    Button(location.name) {
                        selectedLocation = location
                    }
                }
            } label: {
                HStack(spacing: 12) {
                    Image(systemName: "location.fill")
                        .foregroundColor(AppColors.primary)
                        .font(.system(size: 18, weight: .semibold))
                    
                    Text(selectedLocation?.name ?? placeholder)
                        .font(.system(size: 18, weight: .medium))
                        .foregroundColor(
                            selectedLocation == nil
                            ? AppColors.textTertiary
                            : AppColors.textPrimary
                        )
                        .lineLimit(1)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.down")
                        .foregroundColor(AppColors.textSecondary)
                        .font(.system(size: 14, weight: .semibold))
                }
                .padding()
                .frame(height: 58)
                .background(AppColors.inputBackground)
                .clipShape(RoundedRectangle(cornerRadius: 16))
            }
        }
    }
}