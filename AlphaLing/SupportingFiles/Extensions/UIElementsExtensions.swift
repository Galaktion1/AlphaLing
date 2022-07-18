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
    
    func myTaskActionAlert(alertText : String, alertMessage : String, addActionTitle: String, action: ((UIAlertAction) -> Void)?) {
        let alert = UIAlertController(title: alertText, message: alertMessage, preferredStyle: UIAlertController.Style.alert)
        
        alert.addAction(UIAlertAction(title: addActionTitle, style: .default, handler: action))
        alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func logOutActionSheet() {
        let alert = UIAlertController(title: "Log Out", message: "Please Select an Option", preferredStyle: .actionSheet)
        
        
        alert.addAction(UIAlertAction(title: "Log Out", style: .destructive, handler: { (_) in
            
            
            let sb = UIStoryboard(name: "LoginPage", bundle: nil)
            let vc = sb.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            UserDefaults.standard.removeObject(forKey: "UserLoggedIn")
            UserDefaults.standard.removeObject(forKey: "ID")
            
            self.view.window?.rootViewController = vc
            self.view.window?.makeKeyAndVisible()
            let viewModel = LogOutViewModel()
            viewModel.logOutFunc()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
            print("User click Dismiss button")
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    
}


extension String {
    func removeHtmlTags() -> String{
        self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
    
    
    subscript (bounds: CountableClosedRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start...end])
    }
    
    subscript (bounds: CountableRange<Int>) -> String {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return String(self[start..<end])
    }
    
}





@IBDesignable
class DesignableUITextField: UITextField {
    
    // Provides left padding for images
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        var textRect = super.leftViewRect(forBounds: bounds)
        textRect.origin.x += leftPadding
        return textRect
    }
    
    @IBInspectable var leftImage: UIImage? {
        didSet {
            updateView()
        }
    }
    
    @IBInspectable var leftPadding: CGFloat = 0
    
    @IBInspectable var color: UIColor = UIColor.lightGray {
        didSet {
            updateView()
        }
    }
    
    func updateView() {
        if let image = leftImage {
            leftViewMode = UITextField.ViewMode.always
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
            imageView.contentMode = .scaleAspectFit
            imageView.image = image
            // Note: In order for your image to use the tint color, you have to select the image in the Assets.xcassets and change the "Render As" property to "Template Image".
            imageView.tintColor = color
            leftView = imageView
        } else {
            leftViewMode = UITextField.ViewMode.never
            leftView = nil
        }
        
        // Placeholder text color
        attributedPlaceholder = NSAttributedString(string: placeholder != nil ?  placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: color])
    }
}
