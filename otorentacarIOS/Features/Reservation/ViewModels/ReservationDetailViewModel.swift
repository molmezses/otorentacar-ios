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
    @Published var phoneCountryCode: String
    @Published var phone: String
    @Published var birthDate: Date
    @Published var email: String
    @Published var flightCode: String

    @Published var isSubmitting: Bool = false
    @Published var errorMessage: String?
    @Published var showSuccessMessage: Bool = false
    
    @Published var reservationCode: String = ""
    @Published var navigateToSuccess: Bool = false
    
    private let reservationService: AddReservationServiceProtocol = AddReservationAPIService()

    let draft: ReservationDraft
    let mode: ReservationDetailMode

    init(draft: ReservationDraft, mode: ReservationDetailMode = .create) {
        self.draft = draft
        self.mode = mode
        self.name = draft.customerInfo.name
        self.surname = draft.customerInfo.surname
        let parsedPhone = Self.parsePhone(draft.customerInfo.phone)
        self.phoneCountryCode = parsedPhone.countryCode
        self.phone = parsedPhone.number
        self.birthDate = draft.customerInfo.birthDate
        self.email = draft.customerInfo.email
        self.flightCode = draft.customerInfo.flightCode
    }

    var selectedVehicle: Vehicle? {
        draft.selectedVehicle
    }

    var selectedExtras: [ExtraService] {
        switch mode {
        case .create:
            return draft.selectedExtras.filter { $0.isSelected || $0.quantity > 0 }

        case .view(let reservation):
            return reservation.extras.compactMap { item in
                guard let extra = item.extra else { return nil }

                return ExtraService(
                    id: extra.id ?? 0,
                    title: extra.name ?? "",
                    description: extra.description,
                    pricePerDay: extra.price ?? 0,
                    maxCount: item.count ?? 1,
                    isSelected: true,
                    quantity: item.count ?? 1,
                    type: (item.count ?? 1) > 1 ? .quantity : .toggle
                )
            }
        }
    }

    var rentalDayCount: Int {
        FormatterHelper.rentalDayCount(
            pickUpDate: draft.pickUpDate,
            pickUpTime: draft.pickUpTime,
            dropOffDate: draft.dropOffDate,
            dropOffTime: draft.dropOffTime
        )
    }

    var vehicleRentalTotal: Double {
        switch mode {
        case .create:
            return selectedVehicle?.totalPrice ?? 0

        case .view(let reservation):
            return max(reservation.totalAmount - extrasTotal, 0)
        }
    }

    var extrasTotal: Double {
        switch mode {
        case .create:
            return selectedExtras.reduce(0) { partial, item in
                let quantity = max(item.quantity, 1)
                return partial + (item.pricePerDay * Double(quantity) * Double(rentalDayCount))
            }

        case .view(let reservation):
            return reservation.extras.reduce(0) { partial, item in
                let price = item.extra?.price ?? 0
                let count = item.count ?? 1
                return partial + (price * Double(count))
            }
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
        screenTitle(language: .turkish)
    }

    func screenTitle(language: HomeLanguage) -> String {
        switch mode {
        case .create:
            return language == .turkish ? "Rezervasyon Detayı" : "Booking Detail"
        case .view:
            return language == .turkish ? "Rezervasyon Bilgileri" : "Booking Info"
        }
    }

    var heroTitle: String {
        heroTitle(language: .turkish)
    }

    func heroTitle(language: HomeLanguage) -> String {
        switch mode {
        case .create:
            return language == .turkish ? "Rezervasyon Detayları" : "Booking Details"
        case .view:
            return language == .turkish ? "Rezervasyonun Hazır" : "Your Booking Is Ready"
        }
    }

    var heroSubtitle: String {
        heroSubtitle(language: .turkish)
    }

    func heroSubtitle(language: HomeLanguage) -> String {
        switch mode {
        case .create:
            return language == .turkish
                ? "Bilgilerini doldurup rezervasyonu tamamlayabilirsin."
                : "Fill in your details to complete the booking."
        case .view:
            return language == .turkish
                ? "Mevcut rezervasyon bilgilerini aşağıda görüntüleyebilirsin."
                : "You can view your current booking details below."
        }
    }

    var actionButtonTitle: String {
        actionButtonTitle(language: .turkish)
    }

    func actionButtonTitle(language: HomeLanguage) -> String {
        if isSubmitting {
            return language == .turkish ? "İşleniyor..." : "Processing..."
        }

        return language == .turkish ? "Rezervasyonu Tamamla" : "Complete Booking"
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
            displayCurrency: draft.displayCurrency,
            selectedExtras: draft.selectedExtras,
            customerInfo: CustomerInfo(
                name: name,
                surname: surname,
                phone: combinedPhone,
                birthDate: birthDate,
                email: email,
                flightCode: flightCode
            )
        )
    }

    func submitReservation(language: HomeLanguage = .turkish) async {
        guard !isReadOnly else { return }

        guard isFormValid else {
            errorMessage = language == .turkish
                ? "Lütfen ad, soyad, telefon, doğum tarihi ve e-posta alanlarını doğru doldurun."
                : "Please fill in name, surname, phone, birth date and email correctly."
            return
        }

        isSubmitting = true
        errorMessage = nil

        do {
            let updatedDraft = buildUpdatedDraft()
            let code = try await reservationService.addReservation(draft: updatedDraft)
            print("REZERVASYON KODU:", code)

            isSubmitting = false
            reservationCode = code
            navigateToSuccess = true
        } catch {
            isSubmitting = false
            errorMessage = error.localizedDescription
        }
    }
    
    func makeStoredReservation() -> StoredReservation? {
        guard let vehicle = selectedVehicle else { return nil }
        guard !reservationCode.isEmpty else { return nil }

        return StoredReservation(
            trackingCode: reservationCode,
            vehicleName: vehicle.name,
            vehicleBrand: vehicle.brand,
            imageURL: vehicle.imageURL,
            pickUpLocation: draft.pickUpLocation?.name ?? "",
            dropOffLocation: draft.dropOffLocation?.name ?? "",
            pickUpDate: draft.pickUpDate,
            dropOffDate: draft.dropOffDate,
            totalAmount: grandTotal,
            currencyCode: draft.currencyCode ?? vehicle.currencyCode,
            status: "Yeni"
        )
    }

    var combinedPhone: String {
        let trimmedCode = phoneCountryCode.trimmingCharacters(in: .whitespacesAndNewlines)
        let trimmedPhone = phone.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !trimmedPhone.isEmpty else { return trimmedPhone }
        if trimmedPhone.hasPrefix("+") { return trimmedPhone }

        return "\(trimmedCode) \(trimmedPhone)"
    }

    private static func parsePhone(_ value: String) -> (countryCode: String, number: String) {
        let trimmed = value.trimmingCharacters(in: .whitespacesAndNewlines)
        guard trimmed.hasPrefix("+") else {
            return ("+90", trimmed)
        }

        let parts = trimmed.split(separator: " ", maxSplits: 1, omittingEmptySubsequences: true)
        guard let first = parts.first else {
            return ("+90", trimmed)
        }

        let countryCode = String(first)
        let number = parts.count > 1 ? String(parts[1]) : ""
        return (countryCode, number)
    }
}
