//
//  LoginViewViewModel.swift
//  AlphaLing
//
//  Created by Gaga Nizharadze on 31.05.22.
//

import Foundation
import UIKit

class LoginViewViewModel {
    
    func modifyTextField(textField: UITextField) {
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 10
        textField.layer.borderColor = UIColor.gray.cgColor
        textField.setLeftPaddingPoints(15)
    }
    
    func checkCompletion(result: Result<String, Error>, viewController: UIViewController) {
        switch result {
        case .success(let final):
            UserDefaults .standard.set(final, forKey: "token")
            print(UserDefaults.standard.string(forKey: "token") ?? "nothing here")

            DispatchQueue.main.async {
                let storyboard = UIStoryboard(name: "MainTabBar", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "MainTabBarController") as! MainTabBarController

                viewController.view.window?.rootViewController = vc
                viewController.view.window?.makeKeyAndVisible()
                
            }
            
            UserDefaults.standard.set(true, forKey: "UserLoggedIn")
            UserDefaults.standard.synchronize()
            
         
            
            
            
            
        case .failure(let failure):
            DispatchQueue.main.async {
                viewController.showAlert(alertText: "Error", alertMessage: "Invalid username or password.", addActionTitle: "Ok")
                print(failure)
                }
                
            }
        
        }
}



class APIService {
    
    func apiCall(username: String, password: String, completionHandler: @escaping (Result<String, Error>) -> Void) {
        
        guard let url = URL(string: "https://alphatest.webmitplan.de/api/auth/login") else { return }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: String] = [
            "username" : username,
                "password" : password,
                "loginScopeKey" : "desk"
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                completionHandler(.failure(Error.self as! Error))
                return }
            
            do{
                let response = try JSONDecoder().decode(SuccessfullyResponse.self, from: data)
                
                if let result = response.accessToken {
//                    print("...\n \(result) ...\n")
                    completionHandler(.success(result))
                }
                
                if let _ = response.error {
                    completionHandler(.failure(APIError.incorrectValues))
                    
                }
            }
            catch {
                print(error)
            }
        }
        
        task.resume()
    }
    
}

enum APIError: Error {
    case incorrectValues
    
}


