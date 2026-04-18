//
//  ReservationSuccessView.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 17.04.2026.
//


import SwiftUI

extension Notification.Name {
    static let resetBookingFlow = Notification.Name("resetBookingFlow")
}



struct ReservationSuccessView: View {
    let reservationCode: String
    @Environment(\.dismiss) private var dismiss
    @State private var copied = false

    var body: some View {
        VStack(spacing: 0) {
            Spacer(minLength: 24)

            ZStack {
                Circle()
                    .fill(AppColors.primarySoft)
                    .frame(width: 108, height: 108)

                Image(systemName: "checkmark.seal.fill")
                    .font(.system(size: 50))
                    .foregroundColor(AppColors.primary)
            }

            VStack(spacing: 12) {
                Text("Rezervasyon Başarıyla Oluşturuldu")
                    .font(.system(size: 30, weight: .bold))
                    .foregroundColor(AppColors.textPrimary)
                    .multilineTextAlignment(.center)
                    .lineLimit(3)
                    .minimumScaleFactor(0.75)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.horizontal, 24)

                Text("Rezervasyonunuz sisteme kaydedildi. Aşağıdaki takip kodu ile rezervasyon detayınızı görüntüleyebilirsiniz.")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(AppColors.textSecondary)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.horizontal, 28)
            }
            .padding(.top, 26)

            VStack(spacing: 14) {
                Text("Takip Kodu")
                    .font(.system(size: 15, weight: .medium))
                    .foregroundColor(AppColors.textSecondary)

                Text(reservationCode)
                    .font(.system(size: 32, weight: .bold))
                    .foregroundColor(AppColors.primary)
                    .tracking(2)

                Button {
                    UIPasteboard.general.string = reservationCode
                    copied = true

                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        copied = false
                    }
                } label: {
                    HStack(spacing: 8) {
                        Image(systemName: copied ? "checkmark" : "doc.on.doc")
                        Text(copied ? "Kopyalandı" : "Kodu Kopyala")
                    }
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundColor(AppColors.primary)
                    .frame(maxWidth: .infinity)
                    .frame(height: 48)
                    .background(AppColors.primarySoft)
                    .clipShape(RoundedRectangle(cornerRadius: 14))
                }
            }
            .padding(22)
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 26))
            .shadow(color: AppColors.shadow, radius: 12, x: 0, y: 6)
            .padding(.horizontal, 20)
            .padding(.top, 28)

            Text("Takip kodunuzu kaybetmeyin. Rezervasyon sorgulama işlemlerinde bu koda ihtiyacınız olacaktır.")
                .font(.system(size: 14, weight: .medium))
                .foregroundColor(AppColors.textSecondary)
                .multilineTextAlignment(.center)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.horizontal, 28)
                .padding(.top, 28)

            Spacer()

            
            Button {
                NotificationCenter.default.post(name: .resetBookingFlow, object: nil)
                dismiss()
            } label: {
                Text("Tamam")
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 56)
                    .background(AppColors.primary)
                    .clipShape(RoundedRectangle(cornerRadius: 18))
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 26)
        }
        .background(AppColors.background.ignoresSafeArea())
        .navigationBarBackButtonHidden(true)
    }
}
