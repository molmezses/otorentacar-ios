//
//  ORTimePickerField.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 8.04.2026.
//


import SwiftUI

struct ORTimePickerField: View {
    let title: String
    @Binding var time: Date
    
    @State private var showTimePickerSheet = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title.uppercased())
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(AppColors.textSecondary)
            
            Button {
                showTimePickerSheet = true
            } label: {
                HStack {
                    Text(FormatterHelper.timeString.string(from: time))
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(AppColors.textPrimary)
                    
                    Spacer()
                    
                    Image(systemName: "clock")
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(AppColors.primary)
                }
                .padding(.horizontal, 16)
                .frame(height: 58)
                .background(AppColors.inputBackground)
                .clipShape(RoundedRectangle(cornerRadius: 16))
            }
            .buttonStyle(.plain)
            .sheet(isPresented: $showTimePickerSheet) {
                NavigationStack {
                    VStack(spacing: 24) {
                        DatePicker(
                            "Saat Seç",
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
                    .navigationTitle("Saat Seç")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .topBarTrailing) {
                            Button("Tamam") {
                                showTimePickerSheet = false
                            }
                            .foregroundColor(AppColors.primary)
                        }
                    }
                    .presentationDetents([.fraction(0.35)])
                }
            }
        }
    }
}