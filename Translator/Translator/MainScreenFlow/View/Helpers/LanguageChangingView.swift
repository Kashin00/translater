//
//  LanguageChangingView.swift
//  Translator
//
//  Created by Матвей Кашин on 13.11.2023.
//

import UIKit

class LanguageChangingView: UIView {
    
    private lazy var sourceLanguageView: LanguageRepresentationView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(LanguageRepresentationView(frame: .zero))
    
    private lazy var expectedLanguageView: LanguageRepresentationView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(LanguageRepresentationView(frame: .zero))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLanguagesView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configute(with current: Language, and expected: Language) {
        sourceLanguageView.configure(with: current)
        expectedLanguageView.configure(with: expected)
    }
    
    private func setupLanguagesView() {
        addSubview(sourceLanguageView)
        addSubview(expectedLanguageView)
        
        NSLayoutConstraint.activate([
            sourceLanguageView.topAnchor.constraint(equalTo: topAnchor),
            sourceLanguageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            sourceLanguageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            sourceLanguageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4),
            
            expectedLanguageView.topAnchor.constraint(equalTo: topAnchor),
            expectedLanguageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            expectedLanguageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            expectedLanguageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.4),
        ])
    }
}
