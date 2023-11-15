//
//  TranslateResponse.swift
//  Translator
//
//  Created by Матвей Кашин on 15.11.2023.
//

import Foundation

struct TranslateResponse: Codable {
    let data: TranslationsResult
}


struct TranslationsResult: Codable {
    let translations: [TranslatedText]
}


struct TranslatedText: Codable {
    let translatedText: String
}
