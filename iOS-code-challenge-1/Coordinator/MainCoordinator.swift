//
//  MainCoordinator.swift
//  iOS-code-challenge-1
//
//  Created by Derek Kim on 2023-03-24.
//

import UIKit

class MainCoordinator: Coordinator {
    var childCoordinator = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Login
    func start() {
        let vc = LoginViewController.instantiate()
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: true)
    }
    
    func goToScheduleVC(isRememberMeChecked: Bool) {
        let vc = ScheduleViewController.instantiate()
        vc.delegate = navigationController.viewControllers.first as? LoginViewController
        vc.isRememberMeChecked = isRememberMeChecked
        navigationController.pushViewController(vc, animated: true)
    }
    
}
