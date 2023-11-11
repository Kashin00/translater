//
//  Coordinator.swift
//  Translator
//
//  Created by Матвей Кашин on 11.11.2023.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get }
    var navigationController: UINavigationController { get }

    func start()
}
