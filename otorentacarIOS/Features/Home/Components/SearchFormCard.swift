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
            
            Toggle(isOn: $viewModel.dropOffDifferentLocation) {
                Text("Farklı bir yerde bırak")
                    .font(.system(size: 18, weight: .regular))
                    .foregroundColor(AppColors.textSecondary)
            }
            .tint(AppColors.primary)
            
            if viewModel.dropOffDifferentLocation {
                ORTextField(
                    title: "Drop-off Location",
                    placeholder: "Dönüş Lokasyonu",
                    text: $viewModel.dropOffLocation,
                    icon: "paperplane.fill"
                )
            }
            
            HStack(spacing: 14) {
                VStack(alignment: .leading, spacing: 10) {
                    Text("PICK-UP DATE")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(AppColors.textSecondary)
                    
                    DatePicker("", selection: $viewModel.pickUpDate, displayedComponents: .date)
                        .labelsHidden()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .frame(height: 58)
                        .background(AppColors.inputBackground)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                }
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("PICK-UP TIME")
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(AppColors.textSecondary)
                    
                    TextField("10:00", text: $viewModel.pickUpTime)
                        .padding()
                        .frame(height: 58)
                        .background(AppColors.inputBackground)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
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

//#Preview {
//    SearchFormCard()
//}
