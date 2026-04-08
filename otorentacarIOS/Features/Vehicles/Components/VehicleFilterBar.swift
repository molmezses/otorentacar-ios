//
//  VehicleFilterBar.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 8.04.2026.
//


import SwiftUI

struct VehicleFilterBar: View {
    @ObservedObject var viewModel: VehicleListViewModel
    
    var body: some View {
        HStack(spacing: 12) {
            filterButton(
                title: viewModel.selectedFilterTitle,
                icon: "slider.horizontal.3"
            ) {
                print("Filter tapped")
            }
            
            Menu {
                ForEach(VehicleSortOption.allCases) { option in
                    Button(option.rawValue) {
                        viewModel.applySort(option)
                    }
                }
            } label: {
                HStack(spacing: 8) {
                    Image(systemName: "arrow.up.arrow.down")
                    Text(viewModel.selectedSortOption.rawValue)
                        .lineLimit(1)
                    Spacer(minLength: 0)
                    Image(systemName: "chevron.down")
                }
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(AppColors.textPrimary)
                .padding(.horizontal, 14)
                .frame(height: 48)
                .frame(maxWidth: .infinity)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 16))
            }
        }
    }
    
    private func filterButton(title: String, icon: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack(spacing: 8) {
                Image(systemName: icon)
                Text(title)
                    .lineLimit(1)
                Spacer(minLength: 0)
            }
            .font(.system(size: 14, weight: .medium))
            .foregroundColor(AppColors.textPrimary)
            .padding(.horizontal, 14)
            .frame(height: 48)
            .frame(maxWidth: .infinity)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 16))
        }
    }
}