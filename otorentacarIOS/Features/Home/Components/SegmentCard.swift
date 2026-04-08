//
//  SegmentCard.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 8.04.2026.
//

import SwiftUI

struct SegmentCard: View {
    let segment: VehicleSegment
    
    var body: some View {
        HStack(spacing: 14) {
            RoundedRectangle(cornerRadius: 16)
                .fill(AppColors.primarySoft)
                .frame(width: 56, height: 56)
                .overlay(
                    Image(systemName: segment.iconName)
                        .foregroundColor(AppColors.primary)
                        .font(.system(size: 22))
                )
            
            VStack(alignment: .leading, spacing: 4) {
                Text(segment.title)
                    .font(.system(size: 20, weight: .semibold))
                
                Text("\(segment.vehicleCount) ARAÇ")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundColor(AppColors.textSecondary)
            }
            
            Spacer()
        }
        .padding()
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 22))
    }
}
