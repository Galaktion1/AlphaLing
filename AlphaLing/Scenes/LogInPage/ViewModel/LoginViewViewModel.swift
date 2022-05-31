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
    
    
}
