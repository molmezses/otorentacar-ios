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
    @State private var selectedMenuDestination: SideMenuDestination? = nil
    
    var body: some View {
        ZStack(alignment: .leading) {
            VStack(spacing: 0) {
                Group {
                    if let selectedMenuDestination {
                        switch selectedMenuDestination {
                        case .about:
                            AboutView {
                                withAnimation(.spring()) {
                                    showMenu.toggle()
                                }
                            }
                        case .services:
                            ServicesView {
                                withAnimation(.spring()) {
                                    showMenu.toggle()
                                }
                            }
                        case .home, .bookings, .contact, .faq:
                            tabContentView
                        }
                    } else {
                        tabContentView
                    }
                }
                
                if selectedMenuDestination == nil {
                    ORTabBar(selectedTab: $selectedTab)
                        .padding(.horizontal, 12)
                        .padding(.bottom, 8)
                        .background(AppColors.background)
                }
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
                    selectedDestination: currentMenuDestination,
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
    
    @ViewBuilder
    private var tabContentView: some View {
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
    
    private var currentMenuDestination: SideMenuDestination {
        if let selectedMenuDestination {
            return selectedMenuDestination
        }
        
        switch selectedTab {
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
                selectedMenuDestination = nil
                selectedTab = .home
            case .bookings:
                selectedMenuDestination = nil
                selectedTab = .bookings
            case .contact:
                selectedMenuDestination = nil
                selectedTab = .contact
            case .about:
                selectedMenuDestination = .about
            case .services:
                selectedMenuDestination = .services
            case .faq:
                selectedMenuDestination = .faq
            }
            showMenu = false
        }
    }
}



