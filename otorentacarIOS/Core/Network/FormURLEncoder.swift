//
//  FormURLEncoder.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 13.04.2026.
//


import Foundation

enum FormURLEncoder {
    static func encode(_ parameters: [String: String]) -> Data? {
        let bodyString = parameters
            .map { key, value in
                let escapedKey = escape(key)
                let escapedValue = escape(value)
                return "\(escapedKey)=\(escapedValue)"
            }
            .joined(separator: "&")
        
        return bodyString.data(using: .utf8)
    }
    
    private static func escape(_ string: String) -> String {
        let generalDelimitersToEncode = ":#[]@"
        let subDelimitersToEncode = "!$&'()*+,;="
        
        let allowedCharacterSet = CharacterSet.urlQueryAllowed.subtracting(
            CharacterSet(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        )
        
        return string.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) ?? string
    }
}