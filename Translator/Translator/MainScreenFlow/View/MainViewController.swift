//
//  MainViewController.swift
//  Translator
//
//  Created by Матвей Кашин on 11.11.2023.
//

import UIKit

class MainViewController: UIViewController {
    
    private var viewModel: MainScreenViewModelInput?
    
    init(viewModel: MainScreenViewModelInput) {
        super.init(nibName: nil, bundle: nil)
        self.viewModel = viewModel
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
