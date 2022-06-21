//
//  LogOutViewModel.swift
//  AlphaLing
//
//  Created by Gaga Nizharadze on 09.06.22.
//

import Foundation
import UIKit

class LogOutViewModel {
    
    private var apiService = LogOutAPICall()
    
    func logOutFunc() {
        apiService.getResponse { (result) in
            switch result {
            case .success(let response):
                print("user logged out status -> \(response)")
                if response {
                    let vc = SettingsViewController()
                    vc.logOutActionSheet()
                }
            case .failure(let error):
                print("error processing json data \(error)")
            }
        }
    }
    
    
    
}
