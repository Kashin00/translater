//
//  TranslationModel.swift
//  Translator
//
//  Created by Матвей Кашин on 15.11.2023.
//

import Foundation

struct TranslationModel: ManagedObjectConvertible {
    
    var inputLanguage: Language
    var expectedLanguage: Language
    var inputText: String
    var expectedText: String
    
    init(inputLanguage: Language, expectedLanguage: Language, inputText: String,
         expectedText: String) {
        self.inputLanguage = inputLanguage
        self.expectedLanguage = expectedLanguage
        self.inputText = inputText
        self.expectedText = expectedText
    }
    
    init(inputLanguage: Language, expectedLanguage: Language) {
        self.inputLanguage = inputLanguage
        self.expectedLanguage = expectedLanguage
        self.inputText = ""
        self.expectedText = ""
    }
    
    init(dbEntity: TranslatorModelEntity) {
        inputLanguage = Language(language: dbEntity.inputCode ?? "")
        expectedLanguage = Language(language: dbEntity.expectedCode ?? "")
        self.inputText = dbEntity.inputText ?? ""
        self.expectedText = dbEntity.expectedText ?? ""
    }
      
    func copyPropertiesTo(_ object: TranslatorModelEntity) {
        object.inputCode = inputLanguage.language
        object.expectedCode = expectedLanguage.language
        object.inputText = inputText
        object.expectedText = expectedText
    }
    
    mutating func changeLanguage() {
        let currentTempLanguage = self.inputLanguage
        self.inputLanguage = self.expectedLanguage
        self.expectedLanguage = currentTempLanguage
    }
}
