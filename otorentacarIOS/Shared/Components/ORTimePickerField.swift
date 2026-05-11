//
//  ORTimePickerField.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 8.04.2026.
//


import SwiftUI

struct ORTimePickerField: View {
    @EnvironmentObject private var languageManager: AppLanguageManager

    let title: String
    @Binding var time: Date
    
    @State private var showTimePickerSheet = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title.uppercased())
                .font(.system(size: 12, weight: .medium))
                .foregroundColor(AppColors.textSecondary)
                .lineLimit(1)
                .minimumScaleFactor(0.72)
            
            Button {
                showTimePickerSheet = true
            } label: {
                HStack(spacing: 6) {
                    Text(FormatterHelper.timeString.string(from: time))
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(AppColors.textPrimary)
                        .lineLimit(1)
                        .minimumScaleFactor(0.8)
                    
                    Spacer(minLength: 4)
                    
                    Image(systemName: "clock")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(AppColors.primary)
                }
                .padding(.horizontal, 10)
                .frame(height: 58)
                .background(AppColors.inputBackground)
                .clipShape(RoundedRectangle(cornerRadius: 16))
            }
            .buttonStyle(.plain)
            .sheet(isPresented: $showTimePickerSheet) {
                NavigationStack {
                    VStack(spacing: 24) {
                        DatePicker(
                            languageManager.localized(turkish: "Saat Seç", english: "Select Time"),
                            selection: $time,
                            displayedComponents: .hourAndMinute
                        )
                        .datePickerStyle(.wheel)
                        .labelsHidden()
                        .tint(AppColors.primary)
                        .padding()
                        
                        Spacer()
                    }
                    .padding(.top, 20)
                    .navigationTitle(languageManager.localized(turkish: "Saat Seç", english: "Select Time"))
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            Button(languageManager.localized(turkish: "Tamam", english: "Done")) {
                                showTimePickerSheet = false
                            }
                            .foregroundColor(AppColors.primary)
                        }
                    }
                    .presentationDetents([.fraction(0.35)])
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
