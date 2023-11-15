//
//  MainScreenViewModelDataHandler.swift
//  Translator
//
//  Created by Матвей Кашин on 11.11.2023.
//

import Foundation

protocol MainScreenViewModelDataHandlerInput: AnyObject {
    func getLanguages() throws -> [Language]
    func transtaledText(for model: TranslationModel) -> String?
}

class MainScreenViewModelDataHandler: MainScreenViewModelDataHandlerInput {
    
    private var fetcher: MainScreenViewModelDataFetcherInput
    
    init(fetcher: MainScreenViewModelDataFetcherInput = MainScreenViewModelDataFetcher()) {
        self.fetcher = fetcher
    }
    
    func getLanguages() throws -> [Language] {
        return try fetcher.loadLanguages()
    }
    
    func transtaledText(for model: TranslationModel) -> String? {
        fetcher.transtaledText(for: model)
    }
}
