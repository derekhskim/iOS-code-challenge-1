//
//  AuthService.swift
//  iOS-code-challenge-1
//
//  Created by Derek Kim on 2023-03-25.
//

import Foundation
import FirebaseAuth

class AuthService {
    
    public static let shared = AuthService()
    
    private init() {}
    
    public func signIn(with user: User, completion: @escaping (Error?) -> Void) {
        Auth.auth().signIn(withEmail: user.email, password: user.password) { result, error in
            if let error = error {
                completion(error)
                return
            } else {
                completion(nil)
            }
        }
    }
    
    public func signOut(completion: @escaping (Error?) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(nil)
        } catch let error {
            completion(error)
        }
    }
    
}
