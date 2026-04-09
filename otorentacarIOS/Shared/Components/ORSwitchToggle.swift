//
//  ORSwitchToggle.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 8.04.2026.
//


import SwiftUI

struct ORSwitchToggle: View {
    @Binding var isOn: Bool
    
    var body: some View {
        Button {
            withAnimation(.easeInOut(duration: 0.2)) {
                isOn.toggle()
            }
        } label: {
            ZStack(alignment: isOn ? .trailing : .leading) {
                RoundedRectangle(cornerRadius: 16)
                    .fill(isOn ? AppColors.primary.opacity(0.18) : Color.gray.opacity(0.18))
                    .frame(width: 58, height: 34)
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(isOn ? AppColors.primary.opacity(0.35) : Color.gray.opacity(0.28), lineWidth: 1)
                    )
                
                Circle()
                    .fill(isOn ? AppColors.primary : .white)
                    .frame(width: 28, height: 28)
                    .shadow(color: Color.black.opacity(0.08), radius: 3, x: 0, y: 2)
                    .padding(3)
            }
        }
        .buttonStyle(.plain)
    }
}