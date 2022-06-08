//
//  ViewPagerViewController.swift
//  AlphaLing
//
//  Created by Gaga Nizharadze on 02.06.22.
//

import UIKit

class ViewPagerViewController: UIViewController {
    
    private var view1 = MainView()
    
    var data: MyTasksData? {
        didSet {
            guard let data = data else { return }
            view1.updateMainUIView(data: data)
            
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.overrideUserInterfaceStyle = .light
        self.view.backgroundColor = .white
        self.view.addSubview(viewPager)
        
        NSLayoutConstraint.activate([
            viewPager.widthAnchor.constraint(equalTo: self.view.widthAnchor),
            viewPager.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.8),
            viewPager.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            viewPager.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor)
        ])
        
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationItem.titleView?.isHidden = true
        self.navigationController?.navigationBar.standardAppearance.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    lazy var viewPager: ViewPager = {
        let viewPager = ViewPager(
            tabSizeConfiguration: .fillEqually(height: 60, spacing: 0)
        )
        
//        var view1 = MainView()

//        view1.backgroundColor = .red
        
        let view2 = UIView()
//        view2.backgroundColor = .blue
        
        let view3 = UIView()
//        view3.backgroundColor = UIColor(named: "specialBlue")
        
        
        viewPager.tabbedView.tabs = [
            AppTabItemView(title: "Main"),
            AppTabItemView(title: "Activity"),
            AppTabItemView(title: "Documents")
        ]
        viewPager.pagedView.pages = [
            view1,
            view2,
            view3
        ]
        viewPager.translatesAutoresizingMaskIntoConstraints = false
        return viewPager
    }()
}
