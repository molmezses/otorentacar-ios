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
        
        if let body = buildReservationBody(from: params),
           let bodyString = String(data: body, encoding: .utf8) {
            print("ADD RESERVATION BODY:")
            print(bodyString)
        }

        request.httpBody = buildReservationBody(from: params)
        
        let (data, response) = try await URLSession.shared.data(for: request)

        if let httpResponse = response as? HTTPURLResponse {
            print("ADD RESERVATION STATUS CODE:", httpResponse.statusCode)
        }

        if let rawResponse = String(data: data, encoding: .utf8) {
            print("ADD RESERVATION RAW RESPONSE:")
            print(rawResponse)
        }
        
        guard let httpResponse = response as? HTTPURLResponse,
              200..<300 ~= httpResponse.statusCode else {
            throw URLError(.badServerResponse)
        }
        
        let decoded = try JSONDecoder().decode(AddReservationResponse.self, from: data)
        
        guard decoded.status == 1 else {
            throw NSError(domain: "", code: decoded.status, userInfo: [
                NSLocalizedDescriptionKey: decoded.description ?? "Rezervasyon oluşturulamadı"
            ])
        }
        
        return decoded.data?.reservationCode ?? "-"
    }
    
    private func buildReservationBody(from parameters: [String: String]) -> Data? {
        let bodyString = parameters
            .map { key, value in
                let encodedValue = escapeFormValue(value)
                return "\(key)=\(encodedValue)"
            }
            .joined(separator: "&")
        
        return bodyString.data(using: .utf8)
    }

    private func escapeFormValue(_ string: String) -> String {
        let generalDelimitersToEncode = ":#[]@"
        let subDelimitersToEncode = "!$&'()*+,;="
        
        let allowedCharacterSet = CharacterSet.urlQueryAllowed.subtracting(
            CharacterSet(charactersIn: "\(generalDelimitersToEncode)\(subDelimitersToEncode)")
        )
        
        return string.addingPercentEncoding(withAllowedCharacters: allowedCharacterSet) ?? string
    }
}
