//
//  ReservationDetailViewModel.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 8.04.2026.
//


import Foundation
import Combine

@MainActor
final class ReservationDetailViewModel: ObservableObject {
    @Published var name: String
    @Published var surname: String
    @Published var phone: String
    @Published var birthDate: Date
    @Published var email: String
    @Published var flightCode: String

    @Published var isSubmitting: Bool = false
    @Published var errorMessage: String?
    @Published var showSuccessMessage: Bool = false
    
    private let reservationService: AddReservationServiceProtocol = AddReservationAPIService()

    let draft: ReservationDraft
    let mode: ReservationDetailMode

    init(draft: ReservationDraft, mode: ReservationDetailMode = .create) {
        self.draft = draft
        self.mode = mode
        self.name = draft.customerInfo.name
        self.surname = draft.customerInfo.surname
        self.phone = draft.customerInfo.phone
        self.birthDate = draft.customerInfo.birthDate
        self.email = draft.customerInfo.email
        self.flightCode = draft.customerInfo.flightCode
    }

    var selectedVehicle: Vehicle? {
        draft.selectedVehicle
    }

    var selectedExtras: [ExtraService] {
        draft.selectedExtras.filter { $0.isSelected || $0.quantity > 0 }
    }

    var rentalDayCount: Int {
        let calendar = Calendar.current
        let start = calendar.startOfDay(for: draft.pickUpDate)
        let end = calendar.startOfDay(for: draft.dropOffDate)
        let days = (calendar.dateComponents([.day], from: start, to: end).day ?? 0) + 1
        return max(days, 1)
    }

    var vehicleRentalTotal: Double {
        selectedVehicle?.totalPrice ?? 0
    }

    var extrasTotal: Double {
        selectedExtras.reduce(0) { partial, item in
            let quantity = max(item.quantity, 1)
            return partial + (item.pricePerDay * Double(quantity) * Double(rentalDayCount))
        }
    }

    var subtotal: Double {
        vehicleRentalTotal + extrasTotal
    }

    

    var grandTotal: Double {
        subtotal
    }

    var isFormValid: Bool {
        !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !surname.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !phone.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        email.contains("@")
    }

    var isReadOnly: Bool {
        if case .view = mode {
            return true
        }
        return false
    }

    var screenTitle: String {
        switch mode {
        case .create:
            return "Rezervasyon Detayı"
        case .view:
            return "Rezervasyon Bilgileri"
        }
    }

    var heroTitle: String {
        switch mode {
        case .create:
            return "Rezervasyon Detayları"
        case .view:
            return "Rezervasyonun Hazır"
        }
    }

    var heroSubtitle: String {
        switch mode {
        case .create:
            return "Bilgilerini doldurup rezervasyonu tamamlayabilirsin."
        case .view:
            return "Mevcut rezervasyon bilgilerini aşağıda görüntüleyebilirsin."
        }
    }

    var actionButtonTitle: String {
        isSubmitting ? "İşleniyor..." : "Rezervasyonu Tamamla"
    }

    var reservationStatusText: String? {
        switch mode {
        case .create:
            return nil
        case .view(let reservation):
            return reservation.status
        }
    }

    var trackingCodeText: String? {
        switch mode {
        case .create:
            return nil
        case .view(let reservation):
            return reservation.trackingCode
        }
    }

    func buildUpdatedDraft() -> ReservationDraft {
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
            selectedExtras: draft.selectedExtras,
            customerInfo: CustomerInfo(
                name: name,
                surname: surname,
                phone: phone,
                birthDate: birthDate,
                email: email,
                flightCode: flightCode
            )
        )
    }

    func submitReservation() async {
        guard !isReadOnly else { return }

        guard isFormValid else {
            errorMessage = "Lütfen ad, soyad, telefon, doğum tarihi ve e-posta alanlarını doğru doldurun."
            return
        }

        isSubmitting = true
        errorMessage = nil

        do {
            let updatedDraft = buildUpdatedDraft()
            let reservationCode = try await reservationService.addReservation(draft: updatedDraft)

            print("REZERVASYON KODU:", reservationCode)

            isSubmitting = false
            showSuccessMessage = true
        } catch {
            isSubmitting = false
            errorMessage = error.localizedDescription
        }
    }
}
