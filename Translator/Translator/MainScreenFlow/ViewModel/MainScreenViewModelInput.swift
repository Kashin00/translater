//
//  MainScreenViewModelInput.swift
//  Translator
//
//  Created by Матвей Кашин on 11.11.2023.
//

import Foundation

protocol MainScreenViewModelInput: AnyObject {
    // data
    var languages: [Language]? { get }
    
    // actions
    func viewLoaded()
    
    // bindings
    var bindLanguages: ((_ current: Language, _ expected: Language) -> ())? { get set }
}
