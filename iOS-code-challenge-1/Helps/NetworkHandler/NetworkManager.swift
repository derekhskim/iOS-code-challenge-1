//
//  NetworkManager.swift
//  iOS-code-challenge-1
//
//  Created by Derek Kim on 2023-03-24.
//

import Foundation

class NetworkManager {
    
    public static let shared = NetworkManager()
    
    // MARK: - Login user via "POST" Method
    func login(user: User, completion: @escaping (Result<Bool, Error>) -> Void) {
        guard let url = URL(string: "\(baseUrl)/login") else {
            print("Error: Cannot create URL")
            return
        }
        
        guard let jsonData = try? JSONEncoder().encode(user) else {
            print("Error: Trying to convert model to JSON Data")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "accept")
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            
            if let response = response as? HTTPURLResponse {
                print("Status code: \(response.statusCode)")
            }
            
            guard let data = data else {
                print("Error: Did not receive data")
                return
            }
            
            do {
                guard let jsonObject = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                    print("Error: Cannot convert data to JSON object")
                    return
                }
                guard let prettyJsonData = try? JSONSerialization.data(withJSONObject: jsonObject, options: .prettyPrinted) else {
                    print("Error: Cannot convert JSON object to Pretty JSON data")
                    return
                }
                guard let prettyPrintedJson = String(data: prettyJsonData, encoding: .utf8) else {
                    print("Error: Couldn't print JSON in String")
                    return
                }
                print(prettyPrintedJson)
            } catch {
                print("Error: Trying to convert JSON data to string")
                return
            }
        }
        task.resume()
    }
    
}
