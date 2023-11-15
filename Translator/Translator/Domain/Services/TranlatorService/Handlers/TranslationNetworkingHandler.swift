//
//  TranslationNetworkingHandler.swift
//  Translator
//
//  Created by Матвей Кашин on 15.11.2023.
//

import Foundation

class TranslationFetchingHandler: TranslationHandler {
    
    var nextHandler: TranslationHandler?

    private var networkManager: NetworkManagerInput
    private var dataBaseManager: DataBaseManagerInput
    
    init(networkManager: NetworkManagerInput = NetworkManager(),
         dataBaseManager: DataBaseManagerInput = DataBaseManager()) {
        self.networkManager = networkManager
        self.dataBaseManager = dataBaseManager
    }
    
    func handle(request: TranslationModel) async throws -> String? {
        let endPoint = RequestItem.translate(request)
        let transleResponse: TranslateResponse = try await networkManager.send(endPoint.request)
        var translatedText = ""
        transleResponse.data.translations.forEach {
            translatedText += $0.translatedText
        }
        
        var model = request
        model.expectedText = translatedText
        dataBaseManager.addEntities([model])
        dataBaseManager.saveContext()
        
        return translatedText
    }
}
