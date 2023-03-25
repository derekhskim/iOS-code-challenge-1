//
//  ViewController.swift
//  iOS-code-challenge-1
//
//  Created by Derek Kim on 2023-03-24.
//

import UIKit

class LoginViewController: UIViewController, MainStoryBoarded {
    
    weak var coordinator: MainCoordinator?    
    var isRememberMeChecked = false

    // MARK: - @IBOutlet
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var rememberMeButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    // MARK: - @IBAction
    @IBAction func rememberMeButtonTapped(_ sender: UIButton) {
        isRememberMeChecked.toggle()
        
        sender.setImage(isRememberMeChecked ? CheckImages.checked : CheckImages.unchecked, for: .normal)
        UserDefaults.standard.set(isRememberMeChecked, forKey: "RememberMe")
    }
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        if isRememberMeChecked {
            UserDefaults.standard.set(emailTextField.text, forKey: "UserEmail")
        } else {
            UserDefaults.standard.removeObject(forKey: "UserEmail")
        }
        
        coordinator?.goToScheduleVC()
    }
    
    // MARK: - viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        isRememberMeChecked = UserDefaults.standard.bool(forKey: "RememberMe")
        rememberMeButton.setImage(isRememberMeChecked ? CheckImages.checked : CheckImages.unchecked, for: .normal)
        
        emailTextField.text = UserDefaults.standard.string(forKey: "UserEmail")
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
}

