//
//  APIClient.swift
//  otorentacarIOS
//
//  Created by mustafaolmezses on 8.04.2026.
//

import Foundation

protocol APIClient {
    func request<T: Decodable>(_ endpoint: Endpoint, responseModel: T.Type) async throws -> T
}
