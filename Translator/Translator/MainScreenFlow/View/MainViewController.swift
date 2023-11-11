//
//  MainViewController.swift
//  Translator
//
//  Created by Матвей Кашин on 11.11.2023.
//

import UIKit

class MainViewController: UIViewController {
    
    private var viewModel: MainScreenViewModelInput?
    
    private lazy var translateView: TranslateView = {
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.layer.masksToBounds = true
        $0.layer.cornerRadius = 16
        return $0
    }(TranslateView(frame: .zero))
    
    init(viewModel: MainScreenViewModelInput) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTranslateView()
        setupBindings()
        viewModel?.viewLoaded()
    }
}

// MARK: UI
private extension MainViewController {
    func setupTranslateView() {
        view.addSubview(translateView)
        
        NSLayoutConstraint.activate([
            translateView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            translateView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            translateView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            translateView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.7)
        ])
        
        translateView.typedTextHandler = { [weak self] in 
            if $0.isEmpty {
                print($0)
                self?.translateView.translatedText("")
            } else {
                print($0)
                self?.translateView.translatedText("TranslatedText")
            }
        }
    }
}

// MARK: Bindings
private extension MainViewController {
    func setupBindings() {
        createLanguageBinding()
    }
    
    func createLanguageBinding() {
        viewModel?.bindLanguages = { [weak self] languages in
            print(languages)
        }
    }
}
