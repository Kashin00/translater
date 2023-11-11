//
//  TranslateView.swift
//  Translator
//
//  Created by Матвей Кашин on 11.11.2023.
//

import UIKit

final class TranslateView: UIView {
    
    var typedTextHandler: ((String) -> Void)?
    
    private lazy var entryTextView: EntryTextView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        return $0
    }(EntryTextView(frame: .zero))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .gray
        setupEntryTextView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: TranslateView

private extension TranslateView {
    func setupEntryTextView() {
        addSubview(entryTextView)
        
        NSLayoutConstraint.activate([
            entryTextView.topAnchor.constraint(equalTo: topAnchor),
            entryTextView.leadingAnchor.constraint(equalTo: leadingAnchor),
            entryTextView.trailingAnchor.constraint(equalTo: trailingAnchor),
            entryTextView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        entryTextView.typedTextHandler = { [weak self] in
            self?.typedTextHandler?($0)
        }
    }
}
