//
//  TranslationHandler.swift
//  Translator
//
//  Created by Матвей Кашин on 15.11.2023.
//

import Foundation

protocol TranslationHandler: AnyObject {
    @discardableResult
    func setNext(handler: TranslationHandler) -> TranslationHandler
    func handle(request: TranslationModel) async throws -> String?
    var nextHandler: TranslationHandler? { get set }
}

extension TranslationHandler {
    
    func setNext(handler: TranslationHandler) -> TranslationHandler {
        self.nextHandler = handler
        return handler
    }
    
    func handle(request: TranslationModel) -> String? {
        return nextHandler?.handle(request: request)
    }
}
