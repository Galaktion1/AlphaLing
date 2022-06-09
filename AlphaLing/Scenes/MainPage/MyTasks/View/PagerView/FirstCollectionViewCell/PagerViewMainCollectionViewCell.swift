//
//  PagerViewMainCollectionViewCell.swift
//  AlphaLing
//
//  Created by Gaga Nizharadze on 08.06.22.
//

import UIKit

class PagerViewMainCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var nameTitleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var customerNameLabel: UILabel!
    @IBOutlet weak var deliveryNameLabel: UILabel!
    @IBOutlet weak var baseLabel: UILabel!
    @IBOutlet weak var fareLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    
    func updateMainUIView(data: TaskData) {
        
        configureUIElements(name: data.title ?? "nil",
                            date: data.taskDate  ?? "nil",
                            taskTime: data.taskTime ?? "nil",
                            taskEndTime: data.taskEndTime ?? "nil",
                            customer: "nil",
                            deliveryName: data.taskEndTime ?? "nil",
                            baseText: "\(data.taskUsers?[0].supplierPriceData?.basePrice ?? 0)",
                            fareText: "nil")
        
        
        
    }
    
    private func configureUIElements(name: String,
                             date: String,
                             taskTime: String,
                             taskEndTime: String,
                             customer: String,
                             deliveryName: String,
                             baseText: String,
                             fareText: String) {
        
        nameTitleLabel?.text = name
        dateLabel?.text = date
        timeLabel?.text = "\(taskTime.prefix(5)) - \(taskEndTime.prefix(5))"
        customerNameLabel?.text = customer
        deliveryNameLabel?.text = deliveryName
        baseLabel?.text = baseText
        fareLabel?.text = fareText

    }
}


