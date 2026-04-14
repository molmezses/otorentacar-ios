//
//  ReservationDraft 2.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 14.04.2026.
//


import Foundation

struct ReservationDraft {
    var pickUpLocation: LocationDTO?
    var dropOffLocation: LocationDTO?
    
    var pickUpDate: Date
    var pickUpTime: Date
    var dropOffDate: Date
    var dropOffTime: Date
    
    var selectedVehicle: Vehicle?
    var selectedVehicleModelId: Int?
    var currencyId: Int?
    var currencyCode: String?
    
    var selectedExtras: [ExtraService]
    
    var customerInfo: CustomerInfo
    
    init(
        pickUpLocation: LocationDTO? = nil,
        dropOffLocation: LocationDTO? = nil,
        pickUpDate: Date = Date(),
        pickUpTime: Date = Date(),
        dropOffDate: Date = Date(),
        dropOffTime: Date = Date(),
        selectedVehicle: Vehicle? = nil,
        selectedVehicleModelId: Int? = nil,
        currencyId: Int? = nil,
        currencyCode: String? = nil,
        selectedExtras: [ExtraService] = [],
        customerInfo: CustomerInfo = CustomerInfo()
    ) {
        self.pickUpLocation = pickUpLocation
        self.dropOffLocation = dropOffLocation
        self.pickUpDate = pickUpDate
        self.pickUpTime = pickUpTime
        self.dropOffDate = dropOffDate
        self.dropOffTime = dropOffTime
        self.selectedVehicle = selectedVehicle
        self.selectedVehicleModelId = selectedVehicleModelId
        self.currencyId = currencyId
        self.currencyCode = currencyCode
        self.selectedExtras = selectedExtras
        self.customerInfo = customerInfo
    }
}