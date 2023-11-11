//
//  FileReaderService.swift
//  Translator
//
//  Created by Матвей Кашин on 11.11.2023.
//

import Foundation

protocol FileReaderServiceInput: AnyObject {
    func fetchData(forResource: String, withExtension: String) throws -> Data
}

final class FileReaderService: FileReaderServiceInput {
    func fetchData(forResource: String, withExtension: String) throws -> Data {
        if let url = Bundle.main.url(forResource: forResource, withExtension: withExtension) {
            return try Data(contentsOf: url)
        } else {
            throw FileError.fileNotExisted
        }
    }
}

