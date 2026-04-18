//
//  PriceSearchRequest.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 14.04.2026.
//


import Foundation

struct PriceSearchRequest {
    let token: String
    let pickUpDateTime: String
    let dropOffDateTime: String
    let pickUpLocationPointId: Int
    let dropOffLocationPointId: Int
}