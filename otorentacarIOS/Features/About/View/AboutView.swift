//
//  AboutView.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 9.04.2026.
//


import SwiftUI

struct AboutView: View {
    @EnvironmentObject private var languageManager: AppLanguageManager
    var onMenuTap: () -> Void
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(alignment: .leading, spacing: 24) {
                ORTopBar(onMenuTap: onMenuTap)
                
                titleSection
                
                logoCard
                
                introCard
                
                infoSection(
                    title: languageManager.localized(turkish: "Misyonumuz", english: "Our Mission"),
                    body: languageManager.localized(
                        turkish: "Yüksek kalite anlayışımız, müşteri odaklı yaklaşımlarımız, yetişmiş ve alanında uzman çalışanlarımız ile müşteri memnuniyetine dayalı bir sistem geliştirerek, günlük araç kiralama sektöründe farklılık yaratmak.",
                        english: "To make a difference in daily car rental by building a customer satisfaction focused system with high quality standards, customer-oriented service and experienced staff."
                    )
                )
                
                infoSection(
                    title: languageManager.localized(turkish: "Vizyonumuz", english: "Our Vision"),
                    body: languageManager.localized(
                        turkish: "Yüksek kalite standartları ile müşterilerimizi tanıştırarak uygun fiyat sunarak mutlu ve sadık müşteriler yaratmak. Yenilikçi yaklaşımları, müşteri odaklı hizmet yapısı ve deneyimli ekibi ile günlük araç ve filo kiralama alanında faaliyetini sürdürmektir.",
                        english: "To create happy and loyal customers by combining high quality standards with fair prices, and to continue serving daily and fleet rental needs with an innovative, customer-focused team."
                    )
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
            Text(languageManager.localized(turkish: "Hakkımızda", english: "About Us"))
                .font(.system(size: 32, weight: .bold))
                .foregroundColor(AppColors.textPrimary)
            
            Text(languageManager.localized(turkish: "Otorentacar hakkında temel bilgiler", english: "Key information about Otorentacar"))
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
                    OtorentacarLogoView(width: 238, height: 92, cornerRadius: 18, shadow: true)
                }
            )
            .shadow(color: AppColors.shadow, radius: 12, x: 0, y: 6)
    }
    
    private var introCard: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("Otorentacar")
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(AppColors.textPrimary)
            
            Text(languageManager.localized(
                turkish: "Otorentacar, “yepyeni bir araç kiralama deneyimi” özdeyişiyle çok kısa sürede, araç kiralama sektöründe önemli yatırımlar yaparak büyüyen bir markadır. Her geçen gün artan hizmet noktaları ile kısa sürede sektörün öncü firmaları arasında yer almayı hedeflemektedir.",
                english: "Otorentacar is a growing brand in the car rental sector, built around a fresh rental experience. With an expanding service network, it aims to become one of the leading companies in the industry."
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
                
                Text(languageManager.localized(turkish: "İlkelerimiz", english: "Our Principles"))
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(AppColors.textPrimary)
            }
            
            VStack(alignment: .leading, spacing: 12) {
                principleRow(languageManager.localized(turkish: "Faaliyet gösterilen ülkenin hukuki düzenleme ve kurallarına uygun olarak çalışmalarımızı ve operasyonlarımızı yürütmek.", english: "Conduct our operations in accordance with the laws and regulations of the country we serve."))
                principleRow(languageManager.localized(turkish: "Kaynakları verimli ve etkin kullanarak hizmet performansı ve kalitesini geliştirerek müşteri memnuniyetini artırmak.", english: "Use resources efficiently to improve service quality and customer satisfaction."))
                principleRow(languageManager.localized(turkish: "Müşterilerimizle karşılıklı yarar sağlayan iş birlikleri oluşturmak, mutlak ve kesintisiz müşteri memnuniyetini sürdürülebilir kılmak.", english: "Build mutually beneficial relationships with customers and sustain consistent satisfaction."))
                principleRow(languageManager.localized(turkish: "Tüm müşteriler, iş ortakları ve çalışanlara ilişkin kişisel bilgilerin güvenliğini sağlamak.", english: "Protect personal information belonging to customers, partners and employees."))
                principleRow(languageManager.localized(turkish: "Çevre sağlığı ve iş güvenliği konusunda tehdit oluşturan koşulları gidermek.", english: "Remove conditions that threaten environmental health and workplace safety."))
                principleRow(languageManager.localized(turkish: "Kurumsallaşmaya önem vermek.", english: "Value institutional growth and professionalism."))
                principleRow(languageManager.localized(turkish: "Kurumsal kimliğimizi, zarara uğratacak her türlü kötü kullanıma karşı korumak.", english: "Protect our corporate identity against misuse."))
                principleRow(languageManager.localized(turkish: "Çalışanlarımıza eşit fırsatlar sağlamak.", english: "Provide equal opportunities for our employees."))
                principleRow(languageManager.localized(turkish: "Tüm faaliyetlerimizde dürüstlük ilkesinden ayrılmamak.", english: "Act with honesty in all operations."))
                principleRow(languageManager.localized(turkish: "Hızlı karar almak ve uygulamak.", english: "Make and apply decisions quickly."))
                principleRow(languageManager.localized(turkish: "Müşterilerin, iş ortaklarının ve çalışanların haklarını korumak.", english: "Protect the rights of customers, partners and employees."))
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
