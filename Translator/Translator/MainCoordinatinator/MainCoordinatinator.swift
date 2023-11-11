//
//  MainCoordinatinator.swift
//  Translator
//
//  Created by Матвей Кашин on 11.11.2023.
//

import UIKit

class MainCoordinator: Coordinator {
  
  var childCoordinators: [Coordinator] = []
  var navigationController = UINavigationController()
  
  func start() {
      let mainScreenCoordinator = MainScreenCoordinator(navigationController: navigationController)
      childCoordinators.append(mainScreenCoordinator)
      mainScreenCoordinator.start()
  }
}
