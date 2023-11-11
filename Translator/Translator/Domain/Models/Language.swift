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

struct Language: Codable {
    let language: String
}

