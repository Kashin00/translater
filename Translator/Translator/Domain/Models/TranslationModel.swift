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
    let text: String
    
    init(inputLanguageCode: String, expectedLanguageCode: String, text: String) {
        self.inputLanguageCode = inputLanguageCode
        self.expectedLanguageCode = expectedLanguageCode
        self.text = text
    }
    
    init(dbEntity: TranslatorModelEntity) {
        inputLanguageCode = dbEntity.inputCode ?? ""
        expectedLanguageCode = dbEntity.expectedCoed ?? ""
        text = dbEntity.text ?? ""
    }
      
    func copyPropertiesTo(_ object: TranslatorModelEntity) {
        object.inputCode = inputLanguageCode
        object.expectedCoed = expectedLanguageCode
        object.text = text
    }
}
