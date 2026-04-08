//
//  MainContainerView.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 8.04.2026.
//

import SwiftUI

struct MainContainerView: View {
    @State private var selectedTab: AppTab = .home
    @State private var showMenu = false
    
    var body: some View {
        ZStack(alignment: .leading) {
            VStack(spacing: 0) {
                Group {
                    switch selectedTab {
                    case .home:
                        HomeView {
                            withAnimation(.spring()) {
                                showMenu.toggle()
                            }
                        }
                    case .bookings:
                        BookingQueryView {
                            withAnimation(.spring()) {
                                showMenu.toggle()
                            }
                        }
                    case .search:
                        VehicleSearchPlaceholderView {
                            withAnimation(.spring()) {
                                showMenu.toggle()
                            }
                        }
                    case .contact:
                        ContactPlaceholderView {
                            withAnimation(.spring()) {
                                showMenu.toggle()
                            }
                        }
                    }
                }
                
                ORTabBar(selectedTab: $selectedTab)
                    .padding(.horizontal, 12)
                    .padding(.bottom, 8)
                    .background(AppColors.background)
            }
            .background(AppColors.background.ignoresSafeArea())
            .disabled(showMenu)
            
            if showMenu {
                Color.black.opacity(0.15)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation(.spring()) {
                            showMenu = false
                        }
                    }
                
                SideMenuView {
                    withAnimation(.spring()) {
                        showMenu = false
                    }
                }
                .transition(.move(edge: .leading))
            }
        }
    }
}



