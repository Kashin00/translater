//
//  TranslationDataBaseHandler.swift
//  Translator
//
//  Created by Матвей Кашин on 15.11.2023.
//

import Foundation

class TranslationDataBaseHandler: TranslationHandler {
    
    var nextHandler: TranslationHandler?
    private let dataBase: DataBaseManagerInput
    
    init(dataBase: DataBaseManagerInput = DataBaseManager()) {
        self.dataBase = dataBase
    }
    
    func handle(request: TranslationModel) async throws -> String? {
        if let savedText = try isInDataBase(request) {
            return savedText
        } else {
            return try await nextHandler?.handle(request: request)
        }
    }
    
    private func isInDataBase(_ model: TranslationModel) throws -> String? {
        try dataBase
            .fetchObjectsOf(TranslatorModelEntity.self, predicate: nil)
            .first(where: {
                $0.inputCode == model.inputLanguage.language &&
                $0.expectedCode == model.expectedLanguage.language &&
                $0.inputText == model.inputText
            })?.expectedText
    }
}
