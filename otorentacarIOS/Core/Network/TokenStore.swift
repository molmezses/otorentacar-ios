//
//  TokenStore.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 10.04.2026.
//

import Foundation

protocol TokenStoreProtocol {
    func save(token: String)
    func fetchToken() -> String?
    func clearToken()
}

final class InMemoryTokenStore: TokenStoreProtocol {
    static let shared = InMemoryTokenStore()
    
    private init() {}
    
    private var token: String?
    
    func save(token: String) {
        self.token = token
    }
    
    func fetchToken() -> String? {
        token
    }
    
    func clearToken() {
        token = nil
    }
}
