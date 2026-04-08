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
                fieldTitle("Ad Soyad")
                textField("Mehmet Yılmaz", text: $viewModel.fullName)
                
                HStack(spacing: 14) {
                    VStack(alignment: .leading, spacing: 10) {
                        fieldTitle("Telefon")
                        textField("+90 5XX XXX XX XX", text: $viewModel.phone)
                            .keyboardType(.phonePad)
                    }
                    
                    VStack(alignment: .leading, spacing: 10) {
                        fieldTitle("Doğum Tarihi")
                        
                        DatePicker("", selection: $viewModel.birthDate, displayedComponents: .date)
                            .labelsHidden()
                            .padding()
                            .frame(height: 58)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(viewModel.isReadOnly ? Color.gray.opacity(0.12) : AppColors.inputBackground)
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                            .disabled(viewModel.isReadOnly)
                    }
                }
                
                fieldTitle("E-Posta")
                textField("mehmet@email.com", text: $viewModel.email)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)
                
                fieldTitle("Uçuş Kodu (Opsiyonel)")
                textField("TK 1923", text: $viewModel.flightCode)
            }
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
    }
}
