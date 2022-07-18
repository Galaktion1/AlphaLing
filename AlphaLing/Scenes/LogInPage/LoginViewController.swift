//
//  ViewController.swift
//  AlphaLing
//
//  Created by Gaga Nizharadze on 31.05.22.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var logoImage: UIImageView!
    
    @IBOutlet weak var buttonReference: UIButton!
    
    let api = APIService()
    let viewModel = LoginViewViewModel()
    
    
    
    @IBAction func logInButton(_ sender: UIButton) {
        
        api.apiCall(username: usernameTextField.text ?? "" , password: passwordTextField.text ?? "", completionHandler: { (result) in
            
            self.viewModel.checkCompletion(result: result, viewController: self)
        })
   
    }
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTextField.delegate = self
        usernameTextField.delegate = self
        self.addDoneButtonOnKeyboard()
        navigationController?.navigationBar.isHidden = true
       
        
    }
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.backgroundColor = UIColor(named: "commonColor")
        viewModel.modifyTextField(textField: usernameTextField)
        viewModel.modifyTextField(textField: passwordTextField)
        
        
    }
    
    
    
    private func addDoneButtonOnKeyboard(){
            let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
            doneToolbar.barStyle = .default

            let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))

            let items = [flexSpace, done]
            doneToolbar.items = items
            doneToolbar.sizeToFit()

            usernameTextField.inputAccessoryView = doneToolbar
            passwordTextField.inputAccessoryView = doneToolbar
        }

        @objc func doneButtonAction(){
            usernameTextField.resignFirstResponder()
            passwordTextField.resignFirstResponder()
            
        }
}

extension LoginViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
       
        textField.layer.borderWidth = 3
        textField.layer.cornerRadius = 10
        textField.layer.borderColor = UIColor(named: "specialBlue")?.cgColor
//        textField.setLeftPaddingPoints(5)
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        viewModel.modifyTextField(textField: textField)
    }
}



