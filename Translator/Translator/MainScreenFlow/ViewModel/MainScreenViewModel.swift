//
//  MainScreenViewModel.swift
//  Translator
//
//  Created by Матвей Кашин on 11.11.2023.
//

import Foundation

class MainScreenViewModel: MainScreenViewModelInput {
    
    var languages: [Language]?
    private var currentLanguage: Language?
    private var expectedLanguage: Language?
    
    var bindLanguages: ((_ current: Language, _ expected: Language) -> ())?
    
    private var dataHandler: MainScreenViewModelDataHandlerInput
    
    init(dataHandler: MainScreenViewModelDataHandlerInput = MainScreenViewModelDataHandler()) {
        self.dataHandler = dataHandler
    }
    
    func viewLoaded() {
        fetchLanguages()
    }
    
    func needToChangeLanguage() {
        let currentTempLanguage = self.currentLanguage
        self.currentLanguage = expectedLanguage
        self.expectedLanguage = currentTempLanguage
        
        if let currentLanguage = currentLanguage,
           let expectedLanguage = expectedLanguage {
            bindLanguages?(currentLanguage, expectedLanguage)
        }
    }
    
    private func fetchLanguages() {
        do {
            languages = try dataHandler.getLanguages()
            if let currentLanguage = languages?.first(where: { $0.language == "en" }),
               let expectedLanguage = languages?.first {
                self.currentLanguage = currentLanguage
                self.expectedLanguage = expectedLanguage
                bindLanguages?(currentLanguage, expectedLanguage)
            }
        } catch {
            print(error)
        }
    }
}
