//
//  SettingsViewController.swift
//  AlphaLing
//
//  Created by Gaga Nizharadze on 01.06.22.
//

import UIKit

class SettingsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    @IBAction func logOutButton(_ sender: UIButton) {
        self.logOutActionSheet()
    }
  
}
