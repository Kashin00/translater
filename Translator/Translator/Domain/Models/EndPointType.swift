//
//  EndPointType.swift
//  Translator
//
//  Created by Матвей Кашин on 15.11.2023.
//

import Foundation

protocol EndPointType {
    var baseURL: String { get }
    var path: String { get }
    var headers: [String: String]? { get }
    var body: NSMutableData? { get }
    var url: URL { get }
    var httpMethod: String { get }
    var request: URLRequest { get }
}
