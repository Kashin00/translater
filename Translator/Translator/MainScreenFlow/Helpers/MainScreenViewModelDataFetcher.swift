//
//  MainScreenViewModelDataFetcher.swift
//  Translator
//
//  Created by Матвей Кашин on 11.11.2023.
//

import Foundation

protocol MainScreenViewModelDataFetcherInput: AnyObject {
    func loadLanguages() throws -> [Language]
}

class MainScreenViewModelDataFetcher: MainScreenViewModelDataFetcherInput {
    
    private var decoder: DataDecoderServiceInput
    private var fileReader: FileReaderServiceInput
    
    init(decoder: DataDecoderServiceInput = DataDecoderService(),
         fileReader: FileReaderServiceInput = FileReaderService()) {
        self.decoder = decoder
        self.fileReader = fileReader
    }
    
    func loadLanguages() throws -> [Language] {
        let data = try fileReader.fetchData(forResource: "Languages", withExtension: "json")
        let response: LanguagesResponse = try decoder.dataDecoder(for: data)
        return response.data.languages
    }
}
