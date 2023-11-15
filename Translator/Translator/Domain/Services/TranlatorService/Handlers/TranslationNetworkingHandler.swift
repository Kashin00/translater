//
//  TranslationNetworkingHandler.swift
//  Translator
//
//  Created by Матвей Кашин on 15.11.2023.
//

import Foundation

class TranslationNetworkingHandler: TranslationHandler {
    var nextHandler: TranslationHandler?
    
    func handle(request: TranslationModel) -> String? {
//        if fetched {
            
//        } else {
            return nextHandler?.handle(request: request)
//        }
    }
}
