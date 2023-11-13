//
//  Language.swift
//  Translator
//
//  Created by Матвей Кашин on 11.11.2023.
//

import Foundation

struct LanguagesResponse: Codable {
    let data: AllLanguages
}

struct AllLanguages: Codable {
    let languages: [Language]
}

struct Language: Codable, Equatable {
    let language: String
    
    var languageName: String {
        let identifier = (Locale.current as NSLocale).displayName(forKey: .identifier, value: language)
        
        return identifier ?? ""
    }
}

