//
//  ActivityView.swift
//  AlphaLing
//
//  Created by Gaga Nizharadze on 07.07.22.
//

import Foundation
import UIKit

class ActivityView {
    
    static let shared = ActivityView()
    
    var actView: UIView = UIView()
    var loadingView: UIView = UIView()
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    var titleLabel: UILabel = UILabel()
    
    let THEME_COLOUR = UIColor (red:0.188, green:0.682, blue:0.886, alpha:1)
    
    
    func showActivity(myView: UIView, myTitle: String) {
        myView.isUserInteractionEnabled = false
        myView.window?.isUserInteractionEnabled = false
        myView.endEditing(true)
        actView.frame = CGRect(x: 0, y: 0, width: myView.frame.width, height: myView.frame.height)
        actView.center = myView.center
        actView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)

        loadingView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        loadingView.center = myView.center
        loadingView.backgroundColor = THEME_COLOUR
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 15
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        activityIndicator.style = UIActivityIndicatorView.Style.large
        activityIndicator.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2);

        titleLabel.frame = CGRect(x: 5, y: loadingView.frame.height-20, width: loadingView.frame.width-10, height: 20)
        titleLabel.textColor = UIColor.white
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.textAlignment = NSTextAlignment.center
        titleLabel.text = myTitle
        titleLabel.font = .systemFont(ofSize: 10)

        loadingView.addSubview(activityIndicator)
        actView.addSubview(loadingView)
        loadingView.addSubview(titleLabel)
        myView.addSubview(actView)
        activityIndicator.startAnimating()
    }
    
    func removeActivity(myView: UIView) {
        myView.isUserInteractionEnabled = true
        myView.window?.isUserInteractionEnabled = true
        activityIndicator.stopAnimating()
        actView.removeFromSuperview()
    }
    
    
}
