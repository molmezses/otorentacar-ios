//
//  MockExtraService.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 8.04.2026.
//


import Foundation

final class MockExtraService: ExtraServiceProtocol {
    func fetchExtraServices(for vehicle: Vehicle) async throws -> [ExtraService] {
        [
            ExtraService(
                id: 1,
                title: "Mini Hasar Güvencesi",
                description: "Küçük çaplı hasarlar için ek koruma.",
                pricePerDay: 149,
                maxCount: 1,
                isSelected: true,
                quantity: 1,
                type: .toggle
            ),
            ExtraService(
                id: 2,
                title: "Tam Koruma Paketi",
                description: "Daha kapsamlı güvence seçeneği.",
                pricePerDay: 249,
                maxCount: 1,
                isSelected: false,
                quantity: 1,
                type: .single
            ),
            ExtraService(
                id: 3,
                title: "Ek Sürücü",
                description: "Aracı ikinci bir sürücü de kullanabilsin.",
                pricePerDay: 99,
                maxCount: 1,
                isSelected: false,
                quantity: 1,
                type: .toggle
            ),
            ExtraService(
                id: 4,
                title: "Bebek Koltuğu",
                description: "Çocuklu aileler için güvenli koltuk.",
                pricePerDay: 75,
                maxCount: 1,
                isSelected: false,
                quantity: 0,
                type: .quantity
            ),
            ExtraService(
                id: 5,
                title: "Navigasyon",
                description: "Dahili veya taşınabilir navigasyon cihazı.",
                pricePerDay: 60,
                maxCount: 1,
                isSelected: false,
                quantity: 0,
                type: .quantity
            )
        ]
    }
}
