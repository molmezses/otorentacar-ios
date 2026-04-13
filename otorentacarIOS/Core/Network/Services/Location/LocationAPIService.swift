//
//  LocationAPIService.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 13.04.2026.
//


import Foundation

final class LocationAPIService: LocationServiceProtocol {
    
    private let tokenStore: TokenStoreProtocol
    
    init(tokenStore: TokenStoreProtocol = InMemoryTokenStore.shared) {
        self.tokenStore = tokenStore
    }
    
    func fetchLocations() async throws -> [LocationDTO] {
        guard let token = tokenStore.fetchToken(), !token.isEmpty else {
            throw NSError(
                domain: "LocationAPIService",
                code: -1,
                userInfo: [NSLocalizedDescriptionKey: "Geçerli token bulunamadı."]
            )
        }
        
        let urlString = AppConfig.baseURL + "/ws/rentacar/v1/tr/searchLocations"
        
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
        
        let decoded = try JSONDecoder().decode(LocationResponse.self, from: data)
        
        guard decoded.status == 1 else {
            throw NSError(
                domain: "LocationAPIService",
                code: decoded.status,
                userInfo: [NSLocalizedDescriptionKey: decoded.description ?? "Lokasyonlar alınamadı."]
            )
        }
        
        return decoded.data?.list ?? []
    }
}
