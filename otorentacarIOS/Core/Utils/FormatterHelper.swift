//
//  FormatterHelper.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 8.04.2026.
//

import Foundation

enum FormatterHelper {
    static let currency: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "TRY"
        formatter.currencySymbol = "₺"
        formatter.maximumFractionDigits = 0
        formatter.minimumFractionDigits = 0
        formatter.locale = Locale(identifier: "tr_TR")
        return formatter
    }()
    
    static let fullCurrency: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "TRY"
        formatter.currencySymbol = "₺"
        formatter.maximumFractionDigits = 2
        formatter.minimumFractionDigits = 2
        formatter.locale = Locale(identifier: "tr_TR")
        return formatter
    }()
    
    static let shortDate: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "tr_TR")
        formatter.dateFormat = "dd MMM yyyy"
        return formatter
    }()
    
    static let timeString: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "tr_TR")
        formatter.dateFormat = "HH:mm"
        return formatter
    }()
    
    static let apiDateTime: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "tr_TR")
        formatter.dateFormat = "dd.MM.yyyy HH:mm"
        return formatter
    }()

    static func combine(date: Date, time: Date) -> Date {
        let calendar = Calendar.current
        
        let dateParts = calendar.dateComponents([.year, .month, .day], from: date)
        let timeParts = calendar.dateComponents([.hour, .minute], from: time)
        
        var result = DateComponents()
        result.year = dateParts.year
        result.month = dateParts.month
        result.day = dateParts.day
        result.hour = timeParts.hour
        result.minute = timeParts.minute
        
        return calendar.date(from: result) ?? date
    }
}
