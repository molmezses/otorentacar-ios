//
//  PersonalInfoFormSection.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 8.04.2026.
//


import SwiftUI

struct PersonalInfoFormSection: View {
    @ObservedObject var viewModel: ReservationDetailViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            sectionTitle("Kişisel Bilgiler", systemImage: "person.fill")
            
            VStack(alignment: .leading, spacing: 16) {
                HStack(spacing: 14) {
                    VStack(alignment: .leading, spacing: 10) {
                        fieldTitle("Ad")
                        textField("Mehmet", text: $viewModel.name)
                    }

                    VStack(alignment: .leading, spacing: 10) {
                        fieldTitle("Soyad")
                        textField("Yılmaz", text: $viewModel.surname)
                    }
                }

                fieldTitle("Telefon")
                textField("+90 5XX XXX XX XX", text: $viewModel.phone)
                    .keyboardType(.phonePad)

                fieldTitle("Doğum Tarihi")
                DatePicker("", selection: $viewModel.birthDate, displayedComponents: .date)
                    .labelsHidden()
                    .padding()
                    .frame(height: 58)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(viewModel.isReadOnly ? Color.gray.opacity(0.12) : AppColors.inputBackground)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .disabled(viewModel.isReadOnly)

                fieldTitle("E-Posta")
                textField("mehmet@email.com", text: $viewModel.email)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)

                fieldTitle("Uçuş Kodu (Opsiyonel)")
                textField("TK 1923", text: $viewModel.flightCode)
            }
            .padding(18)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 24))
            .shadow(color: AppColors.shadow, radius: 10, x: 0, y: 6)
        }
    }
    
    private func sectionTitle(_ title: String, systemImage: String) -> some View {
        HStack(spacing: 10) {
            Image(systemName: systemImage)
                .foregroundColor(AppColors.primary)
            
            Text(title)
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(AppColors.textPrimary)
        }
    }
    
    private func fieldTitle(_ title: String) -> some View {
        Text(title.uppercased())
            .font(.system(size: 14, weight: .medium))
            .foregroundColor(AppColors.textSecondary)
    }
    
    private func textField(_ placeholder: String, text: Binding<String>) -> some View {
        TextField(placeholder, text: text)
            .padding()
            .frame(height: 58)
            .background(viewModel.isReadOnly ? Color.gray.opacity(0.12) : AppColors.inputBackground)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .disabled(viewModel.isReadOnly)
            .foregroundStyle(.black)
    }
}
