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
        
        bindLanguagesIfAvailable()
    }
    
    func languageDidChanged(from language: Language?, to newLanguage: Language?) {
        if language == currentLanguage {
            currentLanguage = newLanguage
        } else if language == expectedLanguage {
            expectedLanguage = newLanguage
        }
        
        bindLanguagesIfAvailable()    }
    
    private func fetchLanguages() {
        do {
            languages = try dataHandler.getLanguages()
            languages?.removeAll(where: { $0.languageName.isEmpty })
            languages?.sort(by: { $0.languageName < $1.languageName })
            
            self.currentLanguage = languages?.first(where: { $0.language == "en" })
            self.expectedLanguage = languages?.first
            bindLanguagesIfAvailable()
        } catch {
            print(error)
        }
    }
    
    private func bindLanguagesIfAvailable() {
        if let currentLanguage, let expectedLanguage {
            bindLanguages?(currentLanguage, expectedLanguage)
        }
    }
}
