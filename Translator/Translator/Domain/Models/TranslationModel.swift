//
//  TranslationModel.swift
//  Translator
//
//  Created by Матвей Кашин on 15.11.2023.
//

import Foundation

struct TranslationModel: ManagedObjectConvertible {
    
    let inputLanguageCode: String
    let expectedLanguageCode: String
    let inputText: String
    var expectedText: String
    
    init(inputLanguageCode: String, expectedLanguageCode: String, inputText: String,
         expectedText: String) {
        self.inputLanguageCode = inputLanguageCode
        self.expectedLanguageCode = expectedLanguageCode
        self.inputText = inputText
        self.expectedText = expectedText
    }
    
    init(dbEntity: TranslatorModelEntity) {
        inputLanguageCode = dbEntity.inputCode ?? ""
        expectedLanguageCode = dbEntity.expectedCode ?? ""
        self.inputText = dbEntity.inputText ?? ""
        self.expectedText = dbEntity.expectedText ?? ""
    }
      
    func copyPropertiesTo(_ object: TranslatorModelEntity) {
        object.inputCode = inputLanguageCode
        object.expectedCode = expectedLanguageCode
        object.inputText = inputText
        object.expectedText = expectedText
    }
}
