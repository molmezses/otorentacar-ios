//
//  HomeView.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 8.04.2026.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewModel = HomeViewModel()
    @State private var navigateToVehicleList = false
    @State private var searchRequest: ReservationSearchRequest?
    
    var onMenuTap: () -> Void
    
    var body: some View {
        NavigationStack {
            ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 28) {
                    ORTopBar(onMenuTap: onMenuTap)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Mükemmel Sürüşünüzü")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(AppColors.textPrimary)
                        
                        Text("Bugün Keşfedin.")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(AppColors.primary)
                    }
                    
                    SearchFormCard(viewModel: viewModel) {
                        let request = viewModel.buildSearchRequest()
                        searchRequest = request
                        navigateToVehicleList = true
                    }
                    
                    VStack(spacing: 18) {
                        ORSectionHeader(title: "Öne Çıkan Kiralık Araçlar", actionTitle: "Tümünü Gör") {
                            let request = viewModel.buildSearchRequest()
                            searchRequest = request
                            navigateToVehicleList = true
                        }
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 16) {
                                ForEach(viewModel.featuredVehicles) { vehicle in
                                    FeaturedVehicleCard(vehicle: vehicle)
                                }
                            }
                        }
                    }
                    
                    VStack(spacing: 18) {
                        ORSectionHeader(title: "Araç Segmentleri")
                        
                        LazyVGrid(columns: [
                            GridItem(.flexible()),
                            GridItem(.flexible())
                        ], spacing: 16) {
                            ForEach(viewModel.segments) { segment in
                                SegmentCard(segment: segment)
                            }
                        }
                    }
                }
                .padding(.horizontal, 24)
                .padding(.top, 20)
                .padding(.bottom, 24)
            }
            .background(AppColors.background)
            .task {
                viewModel.onAppear()
            }
            .navigationDestination(isPresented: $navigateToVehicleList) {
                if let searchRequest {
                    VehicleListView(searchRequest: searchRequest)
                }
            }
        }
    }
}
