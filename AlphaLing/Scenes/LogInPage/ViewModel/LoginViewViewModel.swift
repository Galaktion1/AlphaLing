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
    
    

