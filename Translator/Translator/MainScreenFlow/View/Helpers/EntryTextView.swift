//
//  EntryTextView.swift
//  Translator
//
//  Created by Матвей Кашин on 11.11.2023.
//

import UIKit

final class EntryTextView: UIView {
    
    var typedTextHandler: ((String) -> Void)?
    
    enum State {
        case placeholder, typing
        
        func reversed() -> State {
            switch self {
            case .placeholder:
                return .typing
            case .typing:
                return .placeholder
            }
        }
    }
    
    private var state: State = .placeholder {
        didSet {
            setupPlaceholder()
        }
    }
    
    private let placeholderText = "Type a text!"
    
    private func setupPlaceholder() {
        switch state {
        case .placeholder:
            inputTextView.textColor = .lightGray
            inputTextView.text = placeholderText
            inputTextView.selectedRange = NSRange(location: 0, length: 0)
        case .typing:
            inputTextView.textColor = .white
            if inputTextView.text == placeholderText {
                inputTextView.text = ""
            }
        }
    }
    
    private lazy var inputTextView: UITextView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.font = UIFont.systemFont(ofSize: 32)
        $0.backgroundColor = .gray
        $0.delegate = self
        return $0
    }(UITextView(frame: .zero))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupInputTextView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupInputTextView() {
        addSubview(inputTextView)
        
        NSLayoutConstraint.activate([
            inputTextView.topAnchor.constraint(equalTo: topAnchor),
            inputTextView.leadingAnchor.constraint(equalTo: leadingAnchor),
            inputTextView.trailingAnchor.constraint(equalTo: trailingAnchor),
            inputTextView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
        
        setupPlaceholder()
    }
}

extension EntryTextView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        state = .typing
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        typedTextHandler?(textView.text)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}
