//
//  SceneDelegate.swift
//  iOS-code-challenge-1
//
//  Created by Derek Kim on 2023-03-24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var coordinator: MainCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = .init(windowScene: windowScene)
        let nv = UINavigationController()
        coordinator = MainCoordinator(navigationController: nv)
        coordinator?.start()
        window?.rootViewController = nv
        window?.makeKeyAndVisible()
        
    }

}

