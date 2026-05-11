//
//  SearchFormCard.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 8.04.2026.
//

import SwiftUI

struct SearchFormCard: View {
    @EnvironmentObject private var languageManager: AppLanguageManager
    @ObservedObject var viewModel: HomeViewModel
    var searchAction: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            ORLocationPickerField(
                title: languageManager.localized(turkish: "Alış Lokasyonu", english: "Pick-up Location"),
                placeholder: languageManager.localized(turkish: "Şehir veya Havalimanı", english: "City or Airport"),
                locations: viewModel.availableLocations,
                selectedLocation: $viewModel.selectedPickUpLocation
            )
            
            HStack {
                Text(languageManager.localized(turkish: "Farklı bir yerde bırak", english: "Drop off somewhere else"))
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(AppColors.textSecondary)
                    .lineLimit(2)
                    .minimumScaleFactor(0.86)
                
                Spacer()
                
                ORSwitchToggle(isOn: $viewModel.dropOffDifferentLocation)
            }

            if viewModel.dropOffDifferentLocation {
                ORLocationPickerField(
                    title: languageManager.localized(turkish: "İade Lokasyonu", english: "Drop-off Location"),
                    placeholder: languageManager.localized(turkish: "Dönüş Lokasyonu", english: "Return Location"),
                    locations: viewModel.availableLocations,
                    selectedLocation: $viewModel.selectedDropOffLocation
                )
            }

            VStack(spacing: 14) {
                HStack(spacing: 10) {
                    ORDateField(
                        title: languageManager.localized(turkish: "Alış Tarihi", english: "Pick-up Date"),
                        date: $viewModel.pickUpDate
                    )
                    .frame(maxWidth: .infinity)

                    ORTimePickerField(
                        title: languageManager.localized(turkish: "Alış Saati", english: "Pick-up Time"),
                        time: $viewModel.pickUpTime
                    )
                    .frame(maxWidth: .infinity)
                }

                HStack(spacing: 10) {
                    ORDateField(
                        title: languageManager.localized(turkish: "İade Tarihi", english: "Drop-off Date"),
                        date: $viewModel.dropOffDate
                    )
                    .frame(maxWidth: .infinity)

                    ORTimePickerField(
                        title: languageManager.localized(turkish: "İade Saati", english: "Drop-off Time"),
                        time: $viewModel.dropOffTime
                    )
                    .frame(maxWidth: .infinity)
                }
            }
            
            ORPrimaryButton(
                title: languageManager.localized(turkish: "Araç Bul", english: "Find Car"),
                action: searchAction
            )
        }
        .padding(20)
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 28))
        .shadow(color: AppColors.shadow, radius: 18, x: 0, y: 8)
    }
}
