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
    let storedReservation: StoredReservation?
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var languageManager: AppLanguageManager
    @State private var copied = false

    var body: some View {
        ZStack(alignment: .topTrailing) {
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
                    Text(languageManager.localized(
                        turkish: "Rezervasyon Başarıyla Oluşturuldu",
                        english: "Booking Created Successfully"
                    ))
                        .font(.system(size: 30, weight: .bold))
                        .foregroundColor(AppColors.textPrimary)
                        .multilineTextAlignment(.center)
                        .lineLimit(3)
                        .minimumScaleFactor(0.75)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.horizontal, 24)

                    Text(languageManager.localized(
                        turkish: "Rezervasyonunuz sisteme kaydedildi. Aşağıdaki takip kodu ile rezervasyon detayınızı görüntüleyebilirsiniz.",
                        english: "Your booking has been saved. You can view the details with the tracking code below."
                    ))
                        .font(.system(size: 16, weight: .medium))
                        .foregroundColor(AppColors.textSecondary)
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.horizontal, 28)
                }
                .padding(.top, 26)

                VStack(spacing: 14) {
                    Text(languageManager.localized(turkish: "Takip Kodu", english: "Tracking Code"))
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
                            Text(copied
                                ? languageManager.localized(turkish: "Kopyalandı", english: "Copied")
                                : languageManager.localized(turkish: "Kodu Kopyala", english: "Copy Code")
                            )
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

                Text(languageManager.localized(
                    turkish: "Takip kodunuzu kaybetmeyin. Rezervasyon sorgulama işlemlerinde bu koda ihtiyacınız olacaktır.",
                    english: "Do not lose your tracking code. You will need it to query your booking."
                ))
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
                    Text(languageManager.localized(turkish: "Tamam", english: "Done"))
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

            LanguageToggleButton()
                .padding(.top, 16)
                .padding(.trailing, 20)
        }
        .background(AppColors.background.ignoresSafeArea())
        .navigationBarBackButtonHidden(true)
        .onAppear {
            if let storedReservation {
                LocalStorageManager.shared.saveReservation(storedReservation)
            }
        }
    }
}
