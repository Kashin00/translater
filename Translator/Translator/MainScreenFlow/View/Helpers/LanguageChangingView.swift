//
//  LanguageChangingView.swift
//  Translator
//
//  Created by Матвей Кашин on 13.11.2023.
//

import UIKit

protocol LanguageChangingViewDelegate: AnyObject {
    func changeButtonTapped()
    func getAllLanguages() -> [Language]
    func languageDidChanged(from language: Language?, to newLanguage: Language?)
}

class LanguageChangingView: UIView {
    
    weak var delegate: LanguageChangingViewDelegate?
    
    private lazy var sourceLanguageView: LanguageRepresentationView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isContextMenuInteractionEnabled = true
        $0.showsMenuAsPrimaryAction = true
        $0.delegate = self
        return $0
    }(LanguageRepresentationView(frame: .zero))
    
    private lazy var expectedLanguageView: LanguageRepresentationView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.isContextMenuInteractionEnabled = true
        $0.showsMenuAsPrimaryAction = true
        $0.delegate = self
        return $0
    }(LanguageRepresentationView(frame: .zero))
    
    private lazy var changeButton: UIButton = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.setImage(UIImage(systemName: "repeat"), for: .normal)
        $0.tintColor = .white
        return $0
    }(UIButton(frame: .zero))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLanguagesView()
        setupChangeButton()
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
    
    private func setupChangeButton() {
        addSubview(changeButton)
        
        changeButton.addTarget(self, action: #selector(changeButtonTapped), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            changeButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            changeButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            changeButton.heightAnchor.constraint(equalToConstant: 24),
            changeButton.widthAnchor.constraint(equalToConstant: 24),
        ])
    }
    
    @objc private func changeButtonTapped() {
        delegate?.changeButtonTapped()
        changeButton.rotate()
    }
}

extension LanguageChangingView: LanguageRepresentationViewDelegate {
    func languageDidChanged(from language: Language?, to newLanguage: Language?) {
        delegate?.languageDidChanged(from: language, to: newLanguage)
    }
    
    func getAllLanguages() -> [Language] {
        delegate?.getAllLanguages() ?? []
    }
}
