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
                    case .contact:
                        ContactView {
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
                
                SideMenuView(
                    selectedDestination: sideMenuDestination(from: selectedTab),
                    onItemTap: { destination in
                        handleMenuSelection(destination)
                    },
                    closeAction: {
                        withAnimation(.spring()) {
                            showMenu = false
                        }
                    }
                )
                .transition(.move(edge: .leading))
            }
        }
    }
    
    private func sideMenuDestination(from tab: AppTab) -> SideMenuDestination {
        switch tab {
        case .home:
            return .home
        case .bookings:
            return .bookings
        case .contact:
            return .contact
        }
    }
    
    private func handleMenuSelection(_ destination: SideMenuDestination) {
        withAnimation(.spring()) {
            switch destination {
            case .home:
                selectedTab = .home
            case .bookings:
                selectedTab = .bookings
            case .contact:
                selectedTab = .contact
            case .about, .services, .faq, .blog:
                break
            }
            showMenu = false
        }
    }
}



