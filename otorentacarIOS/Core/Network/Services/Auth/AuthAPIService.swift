//
//  AuthAPIService.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 10.04.2026.
//


import Foundation

final class AuthAPIService: AuthServiceProtocol {
    
    func connect() async throws -> String {
        let urlString = AppConfig.baseURL + "/ws/auth/v1/tr/connect"
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        
        request.httpBody = FormURLEncoder.encode([
            "username": AppConfig.apiUsername,
            "password": AppConfig.apiPassword
        ])
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse,
              200..<300 ~= httpResponse.statusCode else {
            throw URLError(.badServerResponse)
        }
        
        let decoded = try JSONDecoder().decode(ConnectResponse.self, from: data)
        
        guard decoded.status == 1,
              let token = decoded.data?.token else {
            throw NSError(
                domain: "AuthAPIService",
                code: -1,
                userInfo: [NSLocalizedDescriptionKey: decoded.description ?? "Bağlantı başarısız"]
            )
        }
        
        InMemoryTokenStore.shared.save(token: token)
        return token
    }
}
