//
//  AboutView.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 9.04.2026.
//


import SwiftUI

struct AboutView: View {
    var onMenuTap: () -> Void
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 24) {
                ORTopBar(onMenuTap: onMenuTap)
                
                titleSection
                
                logoCard
                
                introCard
                
                infoSection(
                    title: "Misyonumuz",
                    body: "Yüksek kalite anlayışımız, müşteri odaklı yaklaşımlarımız, yetişmiş ve alanında uzman çalışanlarımız ile müşteri memnuniyetine dayalı bir sistem geliştirerek, günlük araç kiralama sektöründe farklılık yaratmak."
                )
                
                infoSection(
                    title: "Vizyonumuz",
                    body: "Yüksek kalite standartları ile müşterilerimizi tanıştırarak uygun fiyat sunarak mutlu ve sadık müşteriler yaratmak. Yenilikçi yaklaşımları, müşteri odaklı hizmet yapısı ve deneyimli ekibi ile günlük araç ve filo kiralama alanında faaliyetini sürdürmektir."
                )
                
                principlesSection
            }
            .padding(.horizontal, 24)
            .padding(.top, 20)
            .padding(.bottom, 24)
        }
        .background(AppColors.background)
    }
    
    private var titleSection: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Hakkımızda")
                .font(.system(size: 32, weight: .bold))
                .foregroundColor(AppColors.textPrimary)
            
            Text("Otorentacar hakkında temel bilgiler")
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(AppColors.textSecondary)
        }
    }
    
    private var logoCard: some View {
        RoundedRectangle(cornerRadius: 28)
            .fill(AppColors.primary)
            .frame(height: 140)
            .overlay(
                VStack(spacing: 10) {
                    Text("Otorentacar")
                        .font(.system(size: 34, weight: .heavy))
                        .foregroundColor(.white)
                    
                    RoundedRectangle(cornerRadius: 2)
                        .fill(Color.yellow.opacity(0.9))
                        .frame(width: 170, height: 4)
                }
            )
            .shadow(color: AppColors.shadow, radius: 12, x: 0, y: 6)
    }
    
    private var introCard: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("Otorentacar")
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(AppColors.textPrimary)
            
            Text("Otorentacar, “yepyeni bir araç kiralama deneyimi” özdeyişiyle çok kısa sürede, araç kiralama sektöründe önemli yatırımlar yaparak büyüyen bir markadır. Her geçen gün artan hizmet noktaları ile kısa sürede sektörün öncü firmaları arasında yer almayı hedeflemektedir.")
                .font(.system(size: 16, weight: .regular))
                .foregroundColor(AppColors.textSecondary)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(20)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .shadow(color: AppColors.shadow, radius: 10, x: 0, y: 6)
    }
    
    private func infoSection(title: String, body: String) -> some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(spacing: 10) {
                Image(systemName: "hand.thumbsup.fill")
                    .foregroundColor(AppColors.primary)
                
                Text(title)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(AppColors.textPrimary)
            }
            
            Text(body)
                .font(.system(size: 16, weight: .regular))
                .foregroundColor(AppColors.textSecondary)
                .fixedSize(horizontal: false, vertical: true)
        }
        .padding(20)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .shadow(color: AppColors.shadow, radius: 10, x: 0, y: 6)
    }
    
    private var principlesSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(spacing: 10) {
                Image(systemName: "checkmark.seal.fill")
                    .foregroundColor(AppColors.primary)
                
                Text("İlkelerimiz")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(AppColors.textPrimary)
            }
            
            VStack(alignment: .leading, spacing: 12) {
                principleRow("Faaliyet gösterilen ülkenin hukuki düzenleme ve kurallarına uygun olarak çalışmalarımızı ve operasyonlarımızı yürütmek.")
                principleRow("Kaynakları verimli ve etkin kullanarak hizmet performansı ve kalitesini geliştirerek müşteri memnuniyetini artırmak.")
                principleRow("Müşterilerimizle karşılıklı yarar sağlayan iş birlikleri oluşturmak, mutlak ve kesintisiz müşteri memnuniyetini sürdürülebilir kılmak.")
                principleRow("Tüm müşteriler, iş ortakları ve çalışanlara ilişkin kişisel bilgilerin güvenliğini sağlamak.")
                principleRow("Çevre sağlığı ve iş güvenliği konusunda tehdit oluşturan koşulları gidermek.")
                principleRow("Kurumsallaşmaya önem vermek.")
                principleRow("Kurumsal kimliğimizi, zarara uğratacak her türlü kötü kullanıma karşı korumak.")
                principleRow("Çalışanlarımıza eşit fırsatlar sağlamak.")
                principleRow("Tüm faaliyetlerimizde dürüstlük ilkesinden ayrılmamak.")
                principleRow("Hızlı karar almak ve uygulamak.")
                principleRow("Müşterilerin, iş ortaklarının ve çalışanların haklarını korumak.")
            }
        }
        .padding(20)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .shadow(color: AppColors.shadow, radius: 10, x: 0, y: 6)
    }
    
    private func principleRow(_ text: String) -> some View {
        HStack(alignment: .top, spacing: 10) {
            Circle()
                .fill(AppColors.primary)
                .frame(width: 8, height: 8)
                .padding(.top, 7)
            
            Text(text)
                .font(.system(size: 16, weight: .regular))
                .foregroundColor(AppColors.textSecondary)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}