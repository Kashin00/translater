//
//  MainScreenViewModelDataFetcher.swift
//  Translator
//
//  Created by Матвей Кашин on 11.11.2023.
//

import Foundation

protocol MainScreenViewModelDataFetcherInput: AnyObject {
    func loadLanguages() throws -> [Language]
    func transtaledText(for model: TranslationModel) async throws -> String?
}

class MainScreenViewModelDataFetcher: MainScreenViewModelDataFetcherInput {
    
    private var decoder: DataDecoderServiceInput
    private var fileReader: FileReaderServiceInput
    private var translatorService: TranslatorServiceInput
    
    init(decoder: DataDecoderServiceInput = DataDecoderService(),
         fileReader: FileReaderServiceInput = FileReaderService(),
         translatorService: TranslatorServiceInput = TranslatorService()) {
        self.decoder = decoder
        self.fileReader = fileReader
        self.translatorService = translatorService
    }
    
    func loadLanguages() throws -> [Language] {
        let data = try fileReader.fetchData(forResource: "Languages", withExtension: "json")
        let response: LanguagesResponse = try decoder.dataDecoder(for: data)
        return response.data.languages
    }
    
    func transtaledText(for model: TranslationModel) async throws -> String? {
        try await translatorService.translate(with: model)
    }
}
