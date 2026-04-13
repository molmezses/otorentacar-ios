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
    @StateObject private var sessionManager = SessionManager()
    
    var body: some View {
        Group {
            if sessionManager.isLoading && !sessionManager.isReady {
                loadingView
            } else if let errorMessage = sessionManager.errorMessage, !sessionManager.isReady {
                sessionErrorView(message: errorMessage)
            } else {
                mainContent
            }
        }
        .task {
            if !sessionManager.isReady {
                await sessionManager.prepareSession()
            }
        }
    }
    
    private var mainContent: some View {
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
    
    private var loadingView: some View {
        ZStack {
            AppColors.background.ignoresSafeArea()
            
            VStack(spacing: 16) {
                ProgressView()
                Text("Bağlantı hazırlanıyor...")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(AppColors.textSecondary)
            }
        }
    }
    
    private func sessionErrorView(message: String) -> some View {
        ZStack {
            AppColors.background.ignoresSafeArea()
            
            VStack(spacing: 18) {
                Image(systemName: "wifi.exclamationmark")
                    .font(.system(size: 42))
                    .foregroundColor(AppColors.primary)
                
                Text("Bağlantı Kurulamadı")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(AppColors.textPrimary)
                
                Text(message)
                    .font(.system(size: 15, weight: .medium))
                    .foregroundColor(AppColors.textSecondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 24)
                
                Button {
                    Task {
                        await sessionManager.prepareSession()
                    }
                } label: {
                    Text("Tekrar Dene")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(.white)
                        .padding(.horizontal, 24)
                        .frame(height: 52)
                        .background(AppColors.primary)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                }
            }
            .padding(24)
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



