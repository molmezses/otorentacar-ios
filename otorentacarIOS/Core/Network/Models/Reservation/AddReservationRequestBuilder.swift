//
//  AddReservationRequestBuilder.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 16.04.2026.
//


import Foundation

struct AddReservationRequestBuilder {
    static func build(from draft: ReservationDraft) -> [String: String] {
        var params: [String: String] = [:]

        params["pickUpLocationPointId"] = "\(draft.pickUpLocation?.id ?? 0)"
        params["dropOffLocationPointId"] = "\(draft.dropOffLocation?.id ?? 0)"
        params["vehicleModelId"] = "\(draft.selectedVehicleModelId ?? 0)"
        params["pickUpDateTime"] = formatDate(draft.pickUpDate, time: draft.pickUpTime)
        params["dropOffDateTime"] = formatDate(draft.dropOffDate, time: draft.dropOffTime)
        params["name"] = draft.customerInfo.name
        params["surname"] = draft.customerInfo.surname
        params["phone1"] = draft.customerInfo.phone
        params["email"] = draft.customerInfo.email
        params["birthDate"] = formatBirthDate(draft.customerInfo.birthDate)

        if !draft.customerInfo.flightCode.isEmpty {
            params["flightNo"] = draft.customerInfo.flightCode
        }

        let vehicleTotal = draft.selectedVehicle?.totalPrice ?? 0

        let dayCount = FormatterHelper.rentalDayCount(
            pickUpDate: draft.pickUpDate,
            pickUpTime: draft.pickUpTime,
            dropOffDate: draft.dropOffDate,
            dropOffTime: draft.dropOffTime
        )

        let extrasTotal = draft.selectedExtras.reduce(0.0) { partial, extra in
            let quantity = max(extra.quantity, 1)
            return partial + (extra.pricePerDay * Double(quantity) * Double(dayCount))
        }

        params["totalPrice"] = "\(vehicleTotal + extrasTotal)"
        params["currencyId"] = "\(draft.currencyId ?? 0)"
        params["paymentMethodId"] = "3"

        for extra in draft.selectedExtras where extra.isSelected || extra.quantity > 0 {
            let quantity = max(extra.quantity, 1)
            params["extras[\(extra.id)]"] = "\(quantity)"
        }
        
        for (index, age) in draft.childrenAges.enumerated() {
            let trimmed = age.trimmingCharacters(in: .whitespacesAndNewlines)
            if !trimmed.isEmpty {
                params["childrenAges[\(index + 1)]"] = trimmed
            }
        }

        return params
    }
}

private func formatDate(_ date: Date, time: Date) -> String {
    let calendar = Calendar.current
    
    var dateComp = calendar.dateComponents([.year, .month, .day], from: date)
    let timeComp = calendar.dateComponents([.hour, .minute], from: time)
    
    dateComp.hour = timeComp.hour
    dateComp.minute = timeComp.minute
    
    let finalDate = calendar.date(from: dateComp) ?? date
    
    let formatter = DateFormatter()
    formatter.dateFormat = "dd.MM.yyyy HH:mm"
    
    return formatter.string(from: finalDate)
}

private func formatBirthDate(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "dd.MM.yyyy"
    return formatter.string(from: date)
}
