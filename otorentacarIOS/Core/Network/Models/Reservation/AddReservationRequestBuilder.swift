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
        
        // MARK: - Location & Vehicle
        params["pickUpLocationPointId"] = "\(draft.pickUpLocation?.id ?? 0)"
        params["dropOffLocationPointId"] = "\(draft.dropOffLocation?.id ?? 0)"
        params["vehicleModelId"] = "\(draft.selectedVehicleModelId ?? 0)"
        
        // MARK: - Dates
        params["pickUpDateTime"] = formatDate(draft.pickUpDate, time: draft.pickUpTime)
        params["dropOffDateTime"] = formatDate(draft.dropOffDate, time: draft.dropOffTime)
        
        // MARK: - Customer
        params["name"] = draft.customerInfo.name
        params["surname"] = draft.customerInfo.surname
        params["phone1"] = draft.customerInfo.phone
        params["email"] = draft.customerInfo.email
        
        // MARK: - Birth Date
        params["birthDate"] = formatBirthDate(draft.customerInfo.birthDate)
        
        // MARK: - Flight (optional)
        if !draft.customerInfo.flightCode.isEmpty {
            params["flightNo"] = draft.customerInfo.flightCode
        }
        
        // MARK: - Price
        params["totalPrice"] = "\(draft.selectedVehicle?.totalPrice ?? 0)"
        params["currencyId"] = "\(draft.currencyId ?? 0)"
        
        // MARK: - Payment (şimdilik sabit)
        params["paymentMethodId"] = "3" // 3 = Nakit
        
        // MARK: - Extras
        for extra in draft.selectedExtras {
            let key = "extra[\(extra.id)]"
            let value = "\(max(extra.quantity, 1))"
            params[key] = value
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
