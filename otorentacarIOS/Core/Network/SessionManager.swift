//
//  SessionManager.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 13.04.2026.
//


import Foundation
import Combine

@MainActor
final class SessionManager: ObservableObject {
    @Published var isReady: Bool = false
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let authService: AuthServiceProtocol
    private let tokenStore: TokenStoreProtocol
    
    init(
        authService: AuthServiceProtocol = AuthAPIService(),
        tokenStore: TokenStoreProtocol = InMemoryTokenStore.shared
    ) {
        self.authService = authService
        self.tokenStore = tokenStore
    }
    
    func prepareSession() async {
        print("SESSION: prepare başladı")

        if let token = tokenStore.fetchToken(), !token.isEmpty {
            print("SESSION: mevcut token bulundu")
            isReady = true
            return
        }

        print("SESSION: token yok, connect çağrılıyor")
        
        isLoading = true
        errorMessage = nil
        
        do {
            let token = try await authService.connect()
            tokenStore.save(token: token)
            isReady = true
            print("SESSION: token alındı")
        } catch {
            errorMessage = error.localizedDescription
            print("SESSION HATASI:", error.localizedDescription)
            isReady = false
        }
        
        isLoading = false
    }
    
    func clearSession() {
        tokenStore.clearToken()
        isReady = false
        errorMessage = nil
    }
}
