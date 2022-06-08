//
//  MainView.swift
//  AlphaLing
//
//  Created by Gaga Nizharadze on 02.06.22.
//

import UIKit

protocol MyViewDelegate {
    func viewString() -> String;
}

class MainView: UIView {
    
    

    
    @IBOutlet weak var nameTitleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var customerNameLabel: UILabel!
    
    @IBOutlet weak var deliveryNameLabel: UILabel!
    
    @IBOutlet weak var comment1Label: UILabel!
    
    
    @IBOutlet weak var moreCommentLabel: UILabel!
    
    @IBOutlet weak var baseLabel: UILabel!
    @IBOutlet weak var fareLabel: UILabel!
    
    
    

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        configureUIElements(name: "asda", date: "Asda", time: "Asd", customer: "asda", deliveryName: "asda", firstComment: "asdas", moreComment: "asda", baseText: "asdas", fareText: "asda")
        instanceFromNib()
    }
    
    

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        configureUIElements(name: "asda", date: "Asda", time: "Asd", customer: "asda", deliveryName: "asda", firstComment: "asdas", moreComment: "asda", baseText: "asdas", fareText: "asda")
        
    }
    
 


    func instanceFromNib() {
        
        let view = UINib(nibName: "MainViewPagerView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        self.addSubview(view)
    }

    func updateMainUIView(data: MyTasksData) {
        
        configureUIElements(name: data.title ?? "nil", date: data.taskDate  ?? "nil", time: data.taskTime  ?? "nil", customer: "nil", deliveryName: data.taskEndTime ?? "nil", firstComment: "nil", moreComment: "nil", baseText: "nil", fareText: "nil")
        
    }
    
    private func configureUIElements(name: String,
                             date: String,
                             time: String,
                             customer: String,
                             deliveryName: String,
                             firstComment: String,
                             moreComment: String,
                             baseText: String,
                             fareText: String) {
        
        nameTitleLabel?.text = name
        dateLabel?.text = date
        timeLabel?.text = time
        customerNameLabel?.text = customer
        deliveryNameLabel?.text = deliveryName
        comment1Label?.text = firstComment
        moreCommentLabel?.text = moreComment
        baseLabel?.text = baseText
        fareLabel?.text = fareText
        
        self.setNeedsDisplay()

//        return UINib(nibName: "MainViewPagerView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
  
}
