//
//  ContactMapCard.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 8.04.2026.
//

import SwiftUI
import MapKit

struct ContactMapCard: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 38.7704, longitude: 35.4954),
        span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
    )
    
    private let coordinate = CLLocationCoordinate2D(latitude: 38.7704, longitude: 35.4954)
    
    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("Konum")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(AppColors.textPrimary)
            
            Map(coordinateRegion: $region, annotationItems: [MapLocation(coordinate: coordinate)]) { item in
                MapMarker(coordinate: item.coordinate)
            }
            .frame(height: 240)
            .clipShape(RoundedRectangle(cornerRadius: 22))
        }
        .padding(18)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .shadow(color: AppColors.shadow, radius: 10, x: 0, y: 6)
    }
}

private struct MapLocation: Identifiable {
    let id = UUID()
    let coordinate: CLLocationCoordinate2D
}
