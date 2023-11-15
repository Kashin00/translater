//
//  TranslationDataBaseHandler.swift
//  Translator
//
//  Created by Матвей Кашин on 15.11.2023.
//

import Foundation

class TranslationDataBaseHandler: TranslationHandler {
    private let dataBase: DataBaseManagerInput
    
    init(dataBase: DataBaseManagerInput = DataBaseManager()) {
        self.dataBase = dataBase
    }
    
    var nextHandler: TranslationHandler?
    
    func handle(request: TranslationModel) -> String? {
        if let savedText = isInDataBase(request) {
            return savedText
        } else {
            return nextHandler?.handle(request: request)
        }
    }
    
    private func isInDataBase(_ model: TranslationModel) -> String? {
        dataBase
            .fetchObjectsOf(TranslatorModelEntity.self, predicate: nil)
            .first(where: {
                $0.inputCode == model.inputLanguageCode &&
                $0.expectedCode == model.expectedLanguageCode &&
                $0.text == model.text
            })?.text
    }
}
