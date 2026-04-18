//
//  FormatterHelper.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 8.04.2026.
//

import Foundation

enum FormatterHelper {
    
    static func rentalDayCount(
        pickUpDate: Date,
        pickUpTime: Date,
        dropOffDate: Date,
        dropOffTime: Date
    ) -> Int {
        let start = combine(date: pickUpDate, time: pickUpTime)
        let end = combine(date: dropOffDate, time: dropOffTime)
        
        let interval = end.timeIntervalSince(start)
        
        guard interval > 0 else { return 1 }
        
        let days = Int(ceil(interval / (24 * 60 * 60)))
        return max(days, 1)
    }
    
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
    
    static func currencyString(_ value: Double, code: String?) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 0
        formatter.currencyCode = code ?? "EUR"
        formatter.locale = Locale(identifier: "en_IE")
        
        return formatter.string(from: NSNumber(value: value)) ?? "\(value)"
    }
    
    static let apiDateTimeParser: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "tr_TR")
        formatter.dateFormat = "dd.MM.yyyy HH:mm"
        return formatter
    }()
    
    static let reservationDateTimeParser: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
    }()

    static let birthDateParser: DateFormatter = {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "tr_TR")
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter
    }()
}
