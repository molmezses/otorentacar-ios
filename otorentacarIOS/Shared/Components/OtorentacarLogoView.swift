//
//  OtorentacarLogoView.swift
//  otorentacarIOS
//
//  Created by Codex on 11.05.2026.
//

import SwiftUI

struct OtorentacarLogoView: View {
    let width: CGFloat
    let height: CGFloat
    var cornerRadius: CGFloat = 12
    var shadow: Bool = false

    var body: some View {
        Image("logo")
            .resizable()
            .scaledToFill()
            .frame(width: width, height: height)
            .clipShape(RoundedRectangle(cornerRadius: cornerRadius, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                    .stroke(Color.white.opacity(0.35), lineWidth: 1)
            )
            .shadow(color: shadow ? Color.black.opacity(0.14) : .clear, radius: 8, x: 0, y: 4)
    }
}
