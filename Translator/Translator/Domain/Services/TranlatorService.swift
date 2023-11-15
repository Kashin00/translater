//
//  TranlatorService.swift
//  Translator
//
//  Created by Матвей Кашин on 15.11.2023.
//

import Foundation

struct TranslationModel {
    let inputLanguageCode: String
    let expectedLanguageCode: String
    let text: String
}

protocol TranslationHandler: AnyObject {
    @discardableResult
      func setNext(handler: TranslationHandler) -> TranslationHandler
      func handle(request: TranslationModel) -> String?
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

class NetworkManager: TranslationHandler {
    var nextHandler: TranslationHandler?
    
    func handle(request: TranslationModel) -> String? {
//        if fetched {
            
//        } else {
            return nextHandler?.handle(request: request)
//        }
    }
}

protocol TranlatorServiceInput: AnyObject {
    func translate(with model: TranslationModel)
}


class TranlatorService: TranlatorServiceInput {
    
    typealias DataBase = TranslationHandler & DataBaseManagerInput
    
    let dataBaseManager: DataBase = DataBaseManager()
    let networkManager = NetworkManager()
    
    init() {
        dataBaseManager.setNext(handler: networkManager)
    
    }
    
    func translate(with model: TranslationModel) {
        let result = dataBaseManager.handle(request: model)
            // save result to bd
        // return return to screen
    }
}
