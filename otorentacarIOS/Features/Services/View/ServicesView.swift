//
//  ServicesView.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 9.04.2026.
//


import SwiftUI

struct ServicesView: View {
    @EnvironmentObject private var languageManager: AppLanguageManager
    var onMenuTap: () -> Void
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 24) {
                ORTopBar(onMenuTap: onMenuTap)
                
                titleSection
                
                introCard
                
                LazyVStack(spacing: 16) {
                    serviceCard(
                        icon: "phone.fill",
                        title: languageManager.localized(turkish: "7/24 Araç Kiralama Destek Hattı", english: "24/7 Car Rental Support Line"),
                        description: languageManager.localized(
                            turkish: "7 gün 24 saat yol yardımı ekibi. Kiralama süresince meydana gelebilecek acil, öngörülemeyen kaza ve/veya durumlar ile ilgili olarak Otorentacar destek hattına başvurabilirsiniz.",
                            english: "Our roadside support team is available 24/7. You can contact Otorentacar for urgent or unexpected situations during your rental."
                        )
                    )
                    
                    serviceCard(
                        icon: "key.fill",
                        title: languageManager.localized(turkish: "Ücretsiz Teslim İmkanı", english: "Free Delivery Option"),
                        description: languageManager.localized(
                            turkish: "Aracınızı bir telefonla siz nerede olursanız olun ayağınıza getiriyoruz ve bunun için sizden ek ücret talep etmiyoruz.",
                            english: "We can deliver your car to your location with a quick call, without charging an additional fee."
                        )
                    )
                    
                    serviceCard(
                        icon: "leaf.fill",
                        title: languageManager.localized(turkish: "Temiz ve Bakımlı Araçlar", english: "Clean and Maintained Cars"),
                        description: languageManager.localized(
                            turkish: "Müşterilerimizin herhangi bir problem yaşamaması amacıyla araçlarımızı size sunmadan önce yıkayıp ve bakımlarını eksiksiz gözden geçiriyoruz.",
                            english: "Before delivery, our cars are cleaned and checked so you can enjoy a smooth rental experience."
                        )
                    )
                    
                    serviceCard(
                        icon: "car.fill",
                        title: languageManager.localized(turkish: "Lüks ve Konforlu Araçlar", english: "Luxury and Comfortable Cars"),
                        description: languageManager.localized(
                            turkish: "Deneyimli personeli ve güvenli araçlarıyla alışmış olduğunuz konfor ve ayrıcalık, artık lüks araç ihtiyaçlarınızda da aynı özenle size sunulur.",
                            english: "With experienced staff and reliable vehicles, we bring comfort and care to your luxury car needs."
                        )
                    )
                    
                    serviceCard(
                        icon: "square.stack.3d.up.fill",
                        title: languageManager.localized(turkish: "Farklı Araba Seçenekleri", english: "Different Car Options"),
                        description: languageManager.localized(
                            turkish: "Bütçenize uygun size kaliteli araçlar sunuyoruz. Lüks, aile, sedan, ekonomik gibi seçeneklerle araç seçmenizi kolaylaştırıyoruz.",
                            english: "We offer quality cars for different budgets, including luxury, family, sedan and economy options."
                        )
                    )
                }
            }
            .padding(.horizontal, 24)
            .padding(.top, 20)
            .padding(.bottom, 24)
        }
        .background(AppColors.background)
    }
    
    private var titleSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(languageManager.localized(turkish: "Hizmetlerimiz", english: "Our Services"))
                .font(.system(size: 32, weight: .bold))
                .foregroundColor(AppColors.textPrimary)
            
            Text(languageManager.localized(turkish: "Otorentacar ile sunduğumuz avantajlar", english: "Advantages we offer with Otorentacar"))
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(AppColors.textSecondary)
        }
    }
    
    private var introCard: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text(languageManager.localized(
                turkish: "Size uygun fiyatlı araç kiralama seçeneklerini sunuyoruz.",
                english: "We offer affordable car rental options for you."
            ))
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(AppColors.textPrimary)
            
            Text(languageManager.localized(
                turkish: "Otorentacar ile uygun fiyatlı araç kiralama seçeneklerini bulun, hemen yola koyulun. Filomuzdaki araçlar arasında arama yapın. Anında fiyatları karşılaştırın. Ardından seçtiğiniz araç için doğrudan rezervasyon yapın.",
                english: "Find affordable car rental options with Otorentacar and get on the road. Search our fleet, compare prices instantly, then book your selected car directly."
            ))
                .font(.system(size: 16, weight: .regular))
                .foregroundColor(AppColors.textSecondary)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(20)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .shadow(color: AppColors.shadow, radius: 10, x: 0, y: 6)
    }
    
    private func serviceCard(icon: String, title: String, description: String) -> some View {
        HStack(alignment: .top, spacing: 16) {
            RoundedRectangle(cornerRadius: 18)
                .fill(AppColors.primary)
                .frame(width: 64, height: 64)
                .overlay(
                    Image(systemName: icon)
                        .foregroundColor(.white)
                        .font(.system(size: 26, weight: .semibold))
                )
            
            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(.system(size: 22, weight: .bold))
                    .foregroundColor(AppColors.textPrimary)
                    .fixedSize(horizontal: false, vertical: true)
                
                Text(description)
                    .font(.system(size: 16, weight: .regular))
                    .foregroundColor(AppColors.textSecondary)
                    .fixedSize(horizontal: false, vertical: true)
            }
        }
        .padding(20)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .shadow(color: AppColors.shadow, radius: 10, x: 0, y: 6)
    }
}
