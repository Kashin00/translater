//
//  NetworkManager.swift
//  Translator
//
//  Created by Матвей Кашин on 15.11.2023.
//

import Foundation

protocol NetworkManagerInput {
    func send<T: Codable>(_ request: URLRequest) async throws -> T
}

class NetworkManager: NetworkManagerInput {
    func send<T: Codable>(_ request: URLRequest) async throws -> T {
        let (data, _) = try await URLSession.shared.data(for: request)
        return try JSONDecoder().decode(T.self, from: data)
    }
}
