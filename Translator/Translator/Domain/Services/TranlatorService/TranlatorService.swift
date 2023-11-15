//
//  TranlatorService.swift
//  Translator
//
//  Created by Матвей Кашин on 15.11.2023.
//

import Foundation

protocol TranslatorServiceInput: AnyObject {
    func translate(with model: TranslationModel) async throws -> String?
}

class TranslatorService: TranslatorServiceInput {
    
    let dataBaseHandler: TranslationHandler = TranslationDataBaseHandler()
    let networkHandler: TranslationHandler  = TranslationNetworkingHandler()
    
    init() {
        dataBaseHandler.setNext(handler: networkHandler)
    }
    
    func translate(with model: TranslationModel) async throws -> String? {
        try await dataBaseHandler.handle(request: model)
    }
}
