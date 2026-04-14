//
//  ExtraServicesViewModel.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 8.04.2026.
//


import Foundation
import Combine

@MainActor
final class ExtraServicesViewModel: ObservableObject {
    @Published var services: [ExtraService] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    let draft: ReservationDraft

    init(draft: ReservationDraft) {
        self.draft = draft
        self.services = Self.makeMockServices()
    }

    var vehicle: Vehicle? {
        draft.selectedVehicle
    }

    var selectedExtras: [ExtraService] {
        services.filter { $0.isSelected || $0.quantity > 0 }
    }

    func updateToggle(for serviceId: Int, isOn: Bool) {
        guard let index = services.firstIndex(where: { $0.id == serviceId }) else { return }
        services[index].isSelected = isOn

        if !isOn {
            services[index].quantity = 0
        } else if services[index].quantity == 0 {
            services[index].quantity = 1
        }
    }

    func increaseQuantity(for serviceId: Int) {
        guard let index = services.firstIndex(where: { $0.id == serviceId }) else { return }
        services[index].quantity += 1
        services[index].isSelected = true
    }

    func decreaseQuantity(for serviceId: Int) {
        guard let index = services.firstIndex(where: { $0.id == serviceId }) else { return }
        services[index].quantity = max(0, services[index].quantity - 1)
        services[index].isSelected = services[index].quantity > 0
    }

    func buildDraftForReservationDetail() -> ReservationDraft {
        ReservationDraft(
            pickUpLocation: draft.pickUpLocation,
            dropOffLocation: draft.dropOffLocation,
            pickUpDate: draft.pickUpDate,
            pickUpTime: draft.pickUpTime,
            dropOffDate: draft.dropOffDate,
            dropOffTime: draft.dropOffTime,
            selectedVehicle: draft.selectedVehicle,
            selectedVehicleModelId: draft.selectedVehicleModelId,
            currencyId: draft.currencyId,
            currencyCode: draft.currencyCode,
            selectedExtras: selectedExtras,
            customerInfo: draft.customerInfo
        )
    }

    private static func makeMockServices() -> [ExtraService] {
        [
            ExtraService(
                id: 1,
                title: "Muafiyetsiz Kaza Güvencesi",
                description: "Kaza durumunda ek güvence sağlar.",
                pricePerDay: 8,
                isSelected: true,
                quantity: 1,
                type: .toggle
            ),
            ExtraService(
                id: 2,
                title: "Süper Hasar Güvencesi",
                description: "Hasar durumları için genişletilmiş koruma sunar.",
                pricePerDay: 6,
                isSelected: false,
                quantity: 0,
                type: .toggle
            ),
            ExtraService(
                id: 3,
                title: "Navigasyon Cihazı",
                description: "Yolculuk boyunca ek navigasyon desteği sağlar.",
                pricePerDay: 2,
                isSelected: false,
                quantity: 0,
                type: .single
            ),
            ExtraService(
                id: 4,
                title: "Bebek Koltuğu",
                description: "Çocuklu yolculuklar için koltuk seçeneği.",
                pricePerDay: 3,
                isSelected: false,
                quantity: 0,
                type: .quantity
            )
        ]
    }
}
