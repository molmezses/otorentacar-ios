//
//  ReservationQueryPlaceholderView.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 8.04.2026.
//


import SwiftUI

struct ReservationQueryPlaceholderView: View {
    var onMenuTap: () -> Void
    
    var body: some View {
        VStack {
            ORTopBar(onMenuTap: onMenuTap)
                .padding(.horizontal, 24)
                .padding(.top, 20)
            
            Spacer()
            
            Text("Reservation Query Screen")
                .font(.title2.bold())
            
            Spacer()
        }
        .background(AppColors.background)
    }
}