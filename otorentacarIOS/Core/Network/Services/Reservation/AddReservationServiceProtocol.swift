//
//  AddReservationServiceProtocol.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 16.04.2026.
//


import Foundation

protocol AddReservationServiceProtocol {
    func addReservation(draft: ReservationDraft) async throws -> String
}

final class AddReservationAPIService: AddReservationServiceProtocol {
    
    private let tokenStore: TokenStoreProtocol
    
    init(tokenStore: TokenStoreProtocol = InMemoryTokenStore.shared) {
        self.tokenStore = tokenStore
    }
    
    func addReservation(draft: ReservationDraft) async throws -> String {
        
        guard let token = tokenStore.fetchToken() else {
            throw URLError(.userAuthenticationRequired)
        }
        
        var params = AddReservationRequestBuilder.build(from: draft)
        params["token"] = token
        
        let url = URL(string: AppConfig.baseURL + "/ws/rentacar/v1/tr/addReservation")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpBody = FormURLEncoder.encode(params)
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        let decoded = try JSONDecoder().decode(AddReservationResponse.self, from: data)
        
        guard decoded.status == 1 else {
            throw NSError(domain: "", code: decoded.status, userInfo: [
                NSLocalizedDescriptionKey: decoded.description ?? "Rezervasyon oluşturulamadı"
            ])
        }
        
        return decoded.data?.reservationCode ?? "-"
    }
}