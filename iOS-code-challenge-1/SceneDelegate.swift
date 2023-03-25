//
//  SceneDelegate.swift
//  iOS-code-challenge-1
//
//  Created by Derek Kim on 2023-03-24.
//

import UIKit
import FirebaseAuth

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var coordinator: MainCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = .init(windowScene: windowScene)
        let nv = UINavigationController()
        coordinator = MainCoordinator(navigationController: nv)
        window?.rootViewController = nv
        window?.makeKeyAndVisible()
        
        checkAuthentication()
    }

    public func checkAuthentication() {
        if Auth.auth().currentUser == nil {
            coordinator?.start()
        } else {
            coordinator?.goToScheduleVC()
        }
    }


}

