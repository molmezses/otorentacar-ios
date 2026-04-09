//
//  ORDateField.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 8.04.2026.
//


import SwiftUI

struct ORDateField: View {
    let title: String
    @Binding var date: Date
    
    @State private var showDatePickerSheet = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title.uppercased())
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(AppColors.textSecondary)
            
            Button {
                showDatePickerSheet = true
            } label: {
                HStack {
                    Text(FormatterHelper.shortDate.string(from: date))
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(AppColors.textPrimary)
                    
                    Spacer()
                    
                    Image(systemName: "calendar")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(AppColors.primary)
                }
                .padding(.horizontal, 16)
                .frame(height: 58)
                .background(AppColors.inputBackground)
                .clipShape(RoundedRectangle(cornerRadius: 16))
            }
            .buttonStyle(.plain)
            .sheet(isPresented: $showDatePickerSheet) {
                NavigationStack {
                    VStack(spacing: 24) {
                        DatePicker(
                            "Teslim Alma Tarihi",
                            selection: $date,
                            displayedComponents: .date
                        )
                        .datePickerStyle(.graphical)
                        .tint(AppColors.primary)
                        .padding()
                        
                        Spacer()
                    }
                    .padding(.top, 20)
                    .navigationTitle("Tarih Seç")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            Button("Tamam") {
                                showDatePickerSheet = false
                            }
                            .foregroundColor(AppColors.primary)
                        }
                    }
                }
                .presentationDetents([.medium])
            }
        }
    }
}
