//
//  SettingsViewController.swift
//  AlphaLing
//
//  Created by Gaga Nizharadze on 01.06.22.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var languageButtonOutlet: UIButton!
    @IBOutlet weak var logOutButtonOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        languageButtonOutlet?.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
        logOutButtonOutlet?.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.left
    }
    
    @IBAction func logOutButton(_ sender: UIButton) {
        self.logOutActionSheet()
    }
  
}
