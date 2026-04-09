//
//  ServicesView.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 9.04.2026.
//


import SwiftUI

struct ServicesView: View {
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
                        title: "7/24 Araç Kiralama Destek Hattı",
                        description: "7 gün 24 saat yol yardımı ekibi. Kiralama süresince meydana gelebilecek acil, öngörülemeyen kaza ve/veya durumlar ile ilgili olarak Otorentacar destek hattına başvurabilirsiniz."
                    )
                    
                    serviceCard(
                        icon: "key.fill",
                        title: "Ücretsiz Teslim İmkanı",
                        description: "Aracınızı bir telefonla siz nerede olursanız olun ayağınıza getiriyoruz ve bunun için sizden ek ücret talep etmiyoruz."
                    )
                    
                    serviceCard(
                        icon: "leaf.fill",
                        title: "Temiz ve Bakımlı Araçlar",
                        description: "Müşterilerimizin herhangi bir problem yaşamaması amacıyla araçlarımızı size sunmadan önce yıkayıp ve bakımlarını eksiksiz gözden geçiriyoruz."
                    )
                    
                    serviceCard(
                        icon: "car.fill",
                        title: "Lüks ve Konforlu Araçlar",
                        description: "Deneyimli personeli ve güvenli araçlarıyla alışmış olduğunuz konfor ve ayrıcalık, artık lüks araç ihtiyaçlarınızda da aynı özenle size sunulur."
                    )
                    
                    serviceCard(
                        icon: "square.stack.3d.up.fill",
                        title: "Farklı Araba Seçenekleri",
                        description: "Bütçenize uygun size kaliteli araçlar sunuyoruz. Lüks, aile, sedan, ekonomik gibi seçeneklerle araç seçmenizi kolaylaştırıyoruz."
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
            Text("Hizmetlerimiz")
                .font(.system(size: 32, weight: .bold))
                .foregroundColor(AppColors.textPrimary)
            
            Text("Otorentacar ile sunduğumuz avantajlar")
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(AppColors.textSecondary)
        }
    }
    
    private var introCard: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("Size uygun fiyatlı araç kiralama seçeneklerini sunuyoruz.")
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(AppColors.textPrimary)
            
            Text("Otorentacar ile uygun fiyatlı araç kiralama seçeneklerini bulun, hemen yola koyulun. Filomuzdaki araçlar arasında arama yapın. Anında fiyatları karşılaştırın. Ardından seçtiğiniz araç için doğrudan rezervasyon yapın.")
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