//
//  RequestItem.swift
//  Translator
//
//  Created by Матвей Кашин on 15.11.2023.
//

import Foundation

enum RequestItem {
    case translate(_ translateModel: TranslationModel)
}

extension RequestItem: EndPointType {
    var baseURL: String {
        "https://google-translate1.p.rapidapi.com/"
    }
    
    var path: String {
        switch self {
        case .translate:
            return "language/translate/v2"
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .translate:
            return ["content-type": "application/x-www-form-urlencoded",
                    "Accept-Encoding": "application/gzip",
                    "X-RapidAPI-Key": "f5167473cbmsh04bad50e76f13d8p104c45jsnba9e76f247a0",
                    "X-RapidAPI-Host": "google-translate1.p.rapidapi.com"]
        }
    }
    
    var body: NSMutableData? {
        switch self {
        case .translate(let model):
            let postData = NSMutableData(data: "q=\(model.inputText)".data(using: String.Encoding.utf8)!)
            postData.append("&target=\(model.expectedLanguageCode)".data(using: String.Encoding.utf8)!)
            postData.append("&source=\(model.inputLanguageCode)".data(using: String.Encoding.utf8)!)
            return postData
        }
    }
    
    var httpMethod: String {
        switch self {
        case .translate:
            return "POST"
        }
    }
    
    var url: URL {
        return URL(string: baseURL + path)!
    }
    
    var request: URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        request.allHTTPHeaderFields = headers
        request.httpBody = body as? Data
        return request
    }
}
