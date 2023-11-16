//
//  MainScreenViewModel.swift
//  Translator
//
//  Created by Матвей Кашин on 11.11.2023.
//

import Foundation

class MainScreenViewModel: MainScreenViewModelInput {
    
    var languages: [Language]?
    private var translationModel: TranslationModel?
    
    var bindLanguages: ((_ current: Language, _ expected: Language) -> ())?
    var bindTranslation: ((String) -> ())?
    
    private var dataHandler: MainScreenViewModelDataHandlerInput
    
    init(dataHandler: MainScreenViewModelDataHandlerInput = MainScreenViewModelDataHandler()) {
        self.dataHandler = dataHandler
    }
    
    func viewLoaded() {
        fetchLanguages()
    }
    
    func needToChangeLanguage() {
        translationModel?.changeLanguage()
        bindLanguagesIfAvailable()
    }
    
    func languageDidChanged(from language: Language?, to newLanguage: Language?) {
        guard let newLanguage else { return }
        if language == translationModel?.inputLanguage {
            translationModel?.inputLanguage = newLanguage
        } else if language == translationModel?.expectedLanguage {
            translationModel?.expectedLanguage = newLanguage
        }
        
        bindLanguagesIfAvailable()
    }
    
    func translate(text: String?) {
        translationModel?.inputText = text ?? ""
        guard let translationModel else { return }
        
        Task {
            do {
                if let translatedText = try await dataHandler.transtaledText(for: translationModel) {
                    self.translationModel?.expectedText = translatedText
                    bindTranslation?(translatedText)
                } else {
                    bindTranslation?("Translation Error!")
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    private func fetchLanguages() {
        do {
            languages = try dataHandler.getLanguages()
            languages?.removeAll(where: { $0.languageName.isEmpty })
            languages?.sort(by: { $0.languageName < $1.languageName })
            
            if let enLang = languages?.first(where: { $0.language == "en" }),
               let firstLang = languages?.first {
                self.translationModel = TranslationModel(inputLanguage: enLang, expectedLanguage: firstLang)
            }
            bindLanguagesIfAvailable()
        } catch {
            print(error)
        }
    }
    
    private func bindLanguagesIfAvailable() {
        if let currentLanguage = translationModel?.inputLanguage,
            let expectedLanguage = translationModel?.expectedLanguage{
            bindLanguages?(currentLanguage, expectedLanguage)
        }
    }
}
