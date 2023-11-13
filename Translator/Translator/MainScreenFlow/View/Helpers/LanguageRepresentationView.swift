//
//  LanguageRepresentationView.swift
//  Translator
//
//  Created by Матвей Кашин on 13.11.2023.
//

import UIKit

class LanguageRepresentationView: UIView {
    
    private(set) var language: Language?
    
    private lazy var languageNameLabel: UILabel = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.numberOfLines = 1
        $0.textColor = .white
        $0.font = UIFont.systemFont(ofSize: 12)
        return $0
    }(UILabel(frame: .zero))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .gray
        layer.masksToBounds = true
        layer.cornerRadius = 6
        setupLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with language: Language) {
        self.language = language
        languageNameLabel.text = language.languageName
    }
    
    private func setupLabel() {
        addSubview(languageNameLabel)
        
        NSLayoutConstraint.activate([
            languageNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            languageNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
    
}
