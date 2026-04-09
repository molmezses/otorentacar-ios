//
//  SearchFormCard.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 8.04.2026.
//

import SwiftUI

struct SearchFormCard: View {
    @ObservedObject var viewModel: HomeViewModel
    var searchAction: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            ORTextField(
                title: "Pick-up Location",
                placeholder: "Şehir veya Havalimanı",
                text: $viewModel.pickUpLocation,
                icon: "location.fill"
            )
            
            HStack {
                Text("Farklı bir yerde bırak")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundColor(AppColors.textSecondary)
                
                Spacer()
                
                ORSwitchToggle(isOn: $viewModel.dropOffDifferentLocation)
            }

            if viewModel.dropOffDifferentLocation {
                ORTextField(
                    title: "Drop-off Location",
                    placeholder: "Dönüş Lokasyonu",
                    text: $viewModel.dropOffLocation,
                    icon: "paperplane.fill"
                )
            }

            VStack(spacing: 14) {
                HStack(spacing: 14) {
                    ORDateField(
                        title: "Pick-up Date",
                        date: $viewModel.pickUpDate
                    )
                    
                    ORTimePickerField(
                        title: "Pick-up Time",
                        time: $viewModel.pickUpTime
                    )
                }
                
                HStack(spacing: 14) {
                    ORDateField(
                        title: "Drop-off Date",
                        date: $viewModel.dropOffDate
                    )
                    
                    ORTimePickerField(
                        title: "Drop-off Time",
                        time: $viewModel.dropOffTime
                    )
                }
            }
            
            ORPrimaryButton(title: "Araç Bul", action: searchAction)
        }
        .padding(20)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 28))
        .shadow(color: AppColors.shadow, radius: 18, x: 0, y: 8)
    }
}
