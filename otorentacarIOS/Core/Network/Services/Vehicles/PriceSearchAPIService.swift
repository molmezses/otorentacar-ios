//
//  PriceSearchAPIService.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 14.04.2026.
//


import Foundation

final class PriceSearchAPIService: PriceSearchServiceProtocol {
    
    func searchPrices(request: PriceSearchRequest) async throws -> [VehiclePriceDTO] {
        let urlString = AppConfig.baseURL + "/ws/rentacar/v1/tr/searchPrices"
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "POST"
        urlRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        urlRequest.httpBody = FormURLEncoder.encode([
            "token": request.token,
            "pickUpDateTime": request.pickUpDateTime,
            "dropOffDateTime": request.dropOffDateTime,
            "pickUpLocationPointId": String(request.pickUpLocationPointId),
            "dropOffLocationPointId": String(request.dropOffLocationPointId)
        ])
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let httpResponse = response as? HTTPURLResponse,
              200..<300 ~= httpResponse.statusCode else {
            throw URLError(.badServerResponse)
        }
        
        let decoded = try JSONDecoder().decode(PriceSearchResponse.self, from: data)
        
        guard decoded.status == 1 else {
            throw NSError(
                domain: "PriceSearchAPIService",
                code: decoded.status,
                userInfo: [NSLocalizedDescriptionKey: decoded.description ?? "Araçlar alınamadı."]
            )
        }
        
        return decoded.data?.list ?? []
    }
}