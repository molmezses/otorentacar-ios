//
//  PersonalInfoFormSection.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 8.04.2026.
//


import SwiftUI

struct PersonalInfoFormSection: View {
    @EnvironmentObject private var languageManager: AppLanguageManager
    @ObservedObject var viewModel: ReservationDetailViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            sectionTitle(languageManager.localized(turkish: "Kişisel Bilgiler", english: "Personal Information"), systemImage: "person.fill")
            
            VStack(alignment: .leading, spacing: 16) {
                HStack(spacing: 14) {
                    VStack(alignment: .leading, spacing: 10) {
                        fieldTitle(languageManager.localized(turkish: "Ad", english: "Name"))
                        textField("Mehmet", text: $viewModel.name)
                    }

                    VStack(alignment: .leading, spacing: 10) {
                        fieldTitle(languageManager.localized(turkish: "Soyad", english: "Surname"))
                        textField(languageManager.localized(turkish: "Yılmaz", english: "Smith"), text: $viewModel.surname)
                    }
                }

                fieldTitle(languageManager.localized(turkish: "Telefon", english: "Phone"))
                phoneField

                fieldTitle(languageManager.localized(turkish: "Doğum Tarihi", english: "Birth Date"))

                if viewModel.isReadOnly {
                    HStack {
                        Text(languageManager.shortDateString(from: viewModel.birthDate))
                            .font(.system(size: 17, weight: .medium))
                            .foregroundColor(AppColors.textPrimary)

                        Spacer()
                    }
                    .padding()
                    .frame(height: 58)
                    .background(Color.gray.opacity(0.12))
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                } else {
                    DatePicker("", selection: $viewModel.birthDate, displayedComponents: .date)
                        .labelsHidden()
                        .padding()
                        .frame(height: 58)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(AppColors.inputBackground)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                }

                fieldTitle(languageManager.localized(turkish: "E-Posta", english: "Email"))
                textField("mehmet@email.com", text: $viewModel.email)
                    .keyboardType(.emailAddress)
                    .textInputAutocapitalization(.never)

                fieldTitle(languageManager.localized(turkish: "Uçuş Kodu (Opsiyonel)", english: "Flight Code (Optional)"))
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

    private var phoneField: some View {
        HStack(spacing: 10) {
            Menu {
                ForEach(phoneCountryCodes, id: \.self) { code in
                    Button {
                        viewModel.phoneCountryCode = code
                    } label: {
                        HStack {
                            Text(code)
                            if viewModel.phoneCountryCode == code {
                                Image(systemName: "checkmark")
                            }
                        }
                    }
                }
            } label: {
                HStack(spacing: 6) {
                    Text(viewModel.phoneCountryCode)
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(AppColors.textPrimary)
                        .lineLimit(1)

                    Image(systemName: "chevron.down")
                        .font(.system(size: 11, weight: .bold))
                        .foregroundColor(AppColors.primary)
                }
                .frame(width: 86, height: 58)
                .background(viewModel.isReadOnly ? Color.gray.opacity(0.12) : AppColors.inputBackground)
                .clipShape(RoundedRectangle(cornerRadius: 16))
            }
            .disabled(viewModel.isReadOnly)

            TextField(languageManager.localized(turkish: "5XX XXX XX XX", english: "Phone number"), text: $viewModel.phone)
                .keyboardType(.phonePad)
                .padding()
                .frame(height: 58)
                .background(viewModel.isReadOnly ? Color.gray.opacity(0.12) : AppColors.inputBackground)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .disabled(viewModel.isReadOnly)
                .foregroundStyle(.black)
        }
    }

    private var phoneCountryCodes: [String] {
        [
            "+90", "+44", "+1", "+7", "+20", "+27", "+30", "+31", "+32", "+33",
            "+34", "+36", "+39", "+40", "+41", "+43", "+45", "+46", "+47", "+49",
            "+52", "+55", "+61", "+81", "+86", "+971", "+973", "+974", "+994"
        ]
    }
}
