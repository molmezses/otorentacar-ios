//
//  ORDateField.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 8.04.2026.
//


import SwiftUI

struct ORDateField: View {
    @EnvironmentObject private var languageManager: AppLanguageManager

    let title: String
    @Binding var date: Date
    
    @State private var showDatePickerSheet = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title.uppercased())
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(AppColors.textSecondary)
                .lineLimit(1)
                .minimumScaleFactor(0.72)
            
            Button {
                showDatePickerSheet = true
            } label: {
                HStack(spacing: 6) {
                    Text(languageManager.shortDateString(from: date))
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(AppColors.textPrimary)
                        .lineLimit(1)
                        .minimumScaleFactor(0.62)
                    
                    Spacer(minLength: 4)
                    
                    Image(systemName: "calendar")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(AppColors.primary)
                }
                .padding(.horizontal, 10)
                .frame(height: 58)
                .background(AppColors.inputBackground)
                .clipShape(RoundedRectangle(cornerRadius: 16))
            }
            .buttonStyle(.plain)
            .sheet(isPresented: $showDatePickerSheet) {
                NavigationStack {
                    VStack(spacing: 24) {
                        DatePicker(
                            languageManager.localized(turkish: "Teslim Alma Tarihi", english: "Pick-up Date"),
                            selection: $date,
                            displayedComponents: .date
                        )
                        .datePickerStyle(.graphical)
                        .tint(AppColors.primary)
                        .padding()
                        
                        Spacer()
                    }
                    .padding(.top, 20)
                    .navigationTitle(languageManager.localized(turkish: "Tarih Seç", english: "Select Date"))
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            Button(languageManager.localized(turkish: "Tamam", english: "Done")) {
                                showDatePickerSheet = false
                            }
                            .foregroundColor(AppColors.primary)
                        }
                    }
                }
                .presentationDetents([.medium])
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
