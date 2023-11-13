//
//  MainScreenViewModel.swift
//  Translator
//
//  Created by Матвей Кашин on 11.11.2023.
//

import Foundation

class MainScreenViewModel: MainScreenViewModelInput {
    
    var languages: [Language]?
    
    var bindLanguages: ((_ current: Language, _ expected: Language) -> ())?
    
    private var dataHandler: MainScreenViewModelDataHandlerInput
    
    init(dataHandler: MainScreenViewModelDataHandlerInput = MainScreenViewModelDataHandler()) {
        self.dataHandler = dataHandler
    }
    
    func viewLoaded() {
        fetchLanguages()
    }
    
    private func fetchLanguages() {
        do {
            languages = try dataHandler.getLanguages()
            if let currentLanguage = languages?.first(where: { $0.language == "en" }),
               let expectedLanguage = languages?.first {
                bindLanguages?(currentLanguage, expectedLanguage)
            }
        } catch {
            print(error)
        }
    }
}
