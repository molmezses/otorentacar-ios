//
//  ExtraServicesAPIService.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 14.04.2026.
//


import Foundation

final class ExtraServicesAPIService: ExtraServicesServiceProtocol {
    
    private let tokenStore: TokenStoreProtocol
    
    init(tokenStore: TokenStoreProtocol = InMemoryTokenStore.shared) {
        self.tokenStore = tokenStore
    }
    
    func fetchExtraServices() async throws -> [ExtraServiceDTO] {
        guard let token = tokenStore.fetchToken(), !token.isEmpty else {
            throw NSError(
                domain: "ExtraServicesAPIService",
                code: -1,
                userInfo: [NSLocalizedDescriptionKey: "Geçerli token bulunamadı."]
            )
        }
        
        let urlString = AppConfig.baseURL + "/ws/rentacar/v1/tr/searchExtraServices"
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpBody = FormURLEncoder.encode([
            "token": token
        ])
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              200..<300 ~= httpResponse.statusCode else {
            throw URLError(.badServerResponse)
        }
        
        let decoded = try JSONDecoder().decode(ExtraServicesResponse.self, from: data)
        
        guard decoded.status == 1 else {
            throw NSError(
                domain: "ExtraServicesAPIService",
                code: decoded.status,
                userInfo: [NSLocalizedDescriptionKey: decoded.description ?? "Ek hizmetler alınamadı."]
            )
        }
        
        return decoded.data?.list ?? []
    }
}