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
    @Published var fullName: String
    @Published var phone: String
    @Published var birthDate: Date
    @Published var email: String
    @Published var flightCode: String
    
    @Published var isSubmitting: Bool = false
    @Published var errorMessage: String?
    @Published var showSuccessMessage: Bool = false
    
    let draft: ReservationDraft
    
    init(draft: ReservationDraft) {
        self.draft = draft
        self.fullName = draft.customerInfo.fullName
        self.phone = draft.customerInfo.phone
        self.birthDate = draft.customerInfo.birthDate
        self.email = draft.customerInfo.email
        self.flightCode = draft.customerInfo.flightCode
    }
    
    var selectedExtras: [ExtraService] {
        draft.extras.filter { $0.isSelected || $0.quantity > 0 }
    }
    
    var rentalDayCount: Int {
        let calendar = Calendar.current
        let start = calendar.startOfDay(for: draft.searchRequest.pickUpDate)
        let end = calendar.startOfDay(for: draft.searchRequest.dropOffDate)
        let days = calendar.dateComponents([.day], from: start, to: end).day ?? 1
        return max(days, 1)
    }
    
    var vehicleRentalTotal: Double {
        draft.vehicle.totalPrice
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
    
    var taxAmount: Double {
        subtotal * 0.20
    }
    
    var grandTotal: Double {
        subtotal + taxAmount
    }
    
    var isFormValid: Bool {
        !fullName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !phone.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        !email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty &&
        email.contains("@")
    }
    
    func buildUpdatedDraft() -> ReservationDraft {
        ReservationDraft(
            vehicle: draft.vehicle,
            searchRequest: draft.searchRequest,
            extras: draft.extras,
            customerInfo: CustomerInfo(
                fullName: fullName,
                phone: phone,
                birthDate: birthDate,
                email: email,
                flightCode: flightCode
            )
        )
    }
    
    func submitReservation() async {
        guard isFormValid else {
            errorMessage = "Lütfen gerekli alanları doğru şekilde doldurun."
            return
        }
        
        isSubmitting = true
        errorMessage = nil
        
        try? await Task.sleep(nanoseconds: 900_000_000)
        
        isSubmitting = false
        showSuccessMessage = true
    }
}
