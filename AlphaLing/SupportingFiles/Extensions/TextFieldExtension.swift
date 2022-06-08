//
//  TextFieldExtension.swift
//  AlphaLing
//
//  Created by Gaga Nizharadze on 31.05.22.
//

import Foundation
import UIKit

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}

extension UIViewController {
//Show a basic alert
    func showAlert(alertText : String, alertMessage : String, addActionTitle: String) {
        
    let alert = UIAlertController(title: alertText, message: alertMessage, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: addActionTitle, style: .cancel))
//Add more actions as you see fit
self.present(alert, animated: true, completion: nil)
  }
    
}



