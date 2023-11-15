//
//  TranslationNetworkingHandler.swift
//  Translator
//
//  Created by Матвей Кашин on 15.11.2023.
//

import Foundation

class MockNetworkManager {
    
    func fetchData(for text: String) async throws -> String? {
        if text == "1" {
            return "Success"
        } else {
            throw FileError.fileNotExisted
        }
    }
}

class TranslationNetworkingHandler: TranslationHandler {
    
    var nextHandler: TranslationHandler?
    
    func handle(request: TranslationModel) async throws -> String? {
        let a = try await MockNetworkManager().fetchData(for: request.text)
        if a != nil {
            return a
        } else {
        return try await nextHandler?.handle(request: request)
        }
    }
}
