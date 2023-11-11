//
//  DataDecoderService.swift
//  Translator
//
//  Created by Матвей Кашин on 11.11.2023.
//

import Foundation

protocol DataDecoderServiceInput: AnyObject {
    func dataDecoder<T: Decodable>(for data: Data) throws -> T
}

class DataDecoderService: DataDecoderServiceInput {
    func dataDecoder<T: Decodable>(for data: Data) throws -> T {
        return try JSONDecoder().decode(T.self, from: data)
    }
}
