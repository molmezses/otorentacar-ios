//
//  HomePromoBanner.swift
//  otorentacarIOS
//
//  Created by Codex on 10.05.2026.
//

import SwiftUI

struct HomePromoBanner: View {
    let language: HomeLanguage

    var body: some View {
        GeometryReader { proxy in
            let width = proxy.size.width
            let ribbonWidth = max(width - 56, 180)

            ZStack(alignment: .bottom) {
                ZStack(alignment: .topLeading) {
                    Image("homePromoCar")
                        .resizable()
                        .scaledToFill()
                        .frame(width: width, height: 240)
                        .clipped()

                    LinearGradient(
                        colors: [
                            Color.white.opacity(0.20),
                            Color.white.opacity(0.0),
                            Color.black.opacity(0.10)
                        ],
                        startPoint: .top,
                        endPoint: .bottom
                    )

                    VStack(alignment: .leading, spacing: 8) {
                        promoRibbon(
                            title: localized(
                                turkish: "ERKEN REZERVASYON FIRSATI!",
                                english: "EARLY BOOKING DEAL!"
                            ),
                            background: Color.orange,
                            width: ribbonWidth
                        )
                        .rotationEffect(.degrees(-6))

                        promoRibbon(
                            title: localized(
                                turkish: "TATİLE OTO RENT A CAR İLE ÇIK!",
                                english: "START YOUR TRIP WITH OTO RENT A CAR!"
                            ),
                            background: Color(red: 0.02, green: 0.29, blue: 0.55),
                            width: ribbonWidth
                        )
                        .rotationEffect(.degrees(-6))
                    }
                    .padding(.top, 26)
                    .padding(.leading, 18)
                    .frame(width: width, alignment: .leading)
                    .zIndex(2)

                    HStack {
                        Spacer()

                        VStack(alignment: .trailing, spacing: 4) {
                            Text(localized(turkish: "ŞİMDİ", english: "RENT"))
                                .font(.system(size: 16, weight: .black))
                                .foregroundColor(.white)
                                .padding(.horizontal, 12)
                                .frame(height: 30)
                                .background(Color(red: 0.03, green: 0.62, blue: 0.85))

                            Text(localized(turkish: "KIRALA!", english: "NOW!"))
                                .font(.system(size: 18, weight: .black))
                                .foregroundColor(.white)
                                .padding(.horizontal, 12)
                                .frame(height: 32)
                                .background(Color(red: 0.98, green: 0.28, blue: 0.16))
                        }
                        .rotationEffect(.degrees(-3))
                        .padding(.top, 116)
                        .padding(.trailing, 18)
                    }
                    .frame(width: width)
                    .zIndex(2)
                }
                .frame(width: width, height: 240)
                .clipShape(PromoStickerShape())
                .overlay(
                    PromoStickerShape()
                        .stroke(Color.white, lineWidth: 5)
                )
                .shadow(color: AppColors.shadow.opacity(1.2), radius: 14, x: 0, y: 8)

                logoBadge
                    .offset(y: 18)
            }
            .frame(width: width, height: 258)
            .clipped()
        }
        .frame(maxWidth: .infinity)
        .frame(height: 258)
        .clipped()
        .accessibilityElement(children: .combine)
        .accessibilityLabel(localized(turkish: "Erken rezervasyon fırsatı", english: "Early booking deal"))
    }

    private func promoRibbon(title: String, background: Color, width: CGFloat) -> some View {
        Text(title)
            .font(.system(size: 18, weight: .black))
            .foregroundColor(.white)
            .lineLimit(1)
            .minimumScaleFactor(0.58)
            .padding(.horizontal, 10)
            .frame(height: 36)
            .frame(width: width, alignment: .leading)
            .background(background)
    }

    private func localized(turkish: String, english: String) -> String {
        language == .turkish ? turkish : english
    }

    private var logoBadge: some View {
        Capsule()
            .fill(Color.white.opacity(0.96))
            .frame(width: 116, height: 50)
            .shadow(color: Color.black.opacity(0.18), radius: 10, x: 0, y: 5)
            .overlay(
                OtorentacarLogoView(width: 96, height: 34, cornerRadius: 9)
            )
    }
}

private struct PromoStickerShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        let w = rect.width
        let h = rect.height

        path.move(to: CGPoint(x: w * 0.05, y: h * 0.09))
        path.addCurve(to: CGPoint(x: w * 0.34, y: h * 0.03), control1: CGPoint(x: w * 0.15, y: 0), control2: CGPoint(x: w * 0.24, y: h * 0.05))
        path.addCurve(to: CGPoint(x: w * 0.68, y: h * 0.04), control1: CGPoint(x: w * 0.46, y: 0), control2: CGPoint(x: w * 0.57, y: h * 0.02))
        path.addCurve(to: CGPoint(x: w * 0.96, y: h * 0.13), control1: CGPoint(x: w * 0.82, y: h * 0.06), control2: CGPoint(x: w * 0.91, y: h * 0.06))
        path.addCurve(to: CGPoint(x: w * 0.93, y: h * 0.72), control1: CGPoint(x: w, y: h * 0.28), control2: CGPoint(x: w * 0.98, y: h * 0.55))
        path.addCurve(to: CGPoint(x: w * 0.70, y: h * 0.94), control1: CGPoint(x: w * 0.88, y: h * 0.88), control2: CGPoint(x: w * 0.82, y: h * 0.91))
        path.addCurve(to: CGPoint(x: w * 0.33, y: h * 0.97), control1: CGPoint(x: w * 0.58, y: h), control2: CGPoint(x: w * 0.43, y: h * 0.95))
        path.addCurve(to: CGPoint(x: w * 0.04, y: h * 0.83), control1: CGPoint(x: w * 0.18, y: h), control2: CGPoint(x: w * 0.08, y: h * 0.93))
        path.addCurve(to: CGPoint(x: w * 0.03, y: h * 0.30), control1: CGPoint(x: 0, y: h * 0.68), control2: CGPoint(x: w * 0.01, y: h * 0.47))
        path.addCurve(to: CGPoint(x: w * 0.05, y: h * 0.09), control1: CGPoint(x: w * 0.04, y: h * 0.22), control2: CGPoint(x: w * 0.01, y: h * 0.15))
        path.closeSubpath()

        return path
    }
}
