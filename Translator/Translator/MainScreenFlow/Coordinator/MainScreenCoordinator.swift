//
//  MainScreenCoordinator.swift
//  Translator
//
//  Created by Матвей Кашин on 11.11.2023.
//

import UIKit

class MainScreenCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewModel = MainScreenViewModel()
        let vc = MainViewController(viewModel: viewModel)
        navigationController.setViewControllers([vc], animated: false)
    }
}
