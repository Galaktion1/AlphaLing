//
//  PagerViewMainCollectionViewCell.swift
//  AlphaLing
//
//  Created by Gaga Nizharadze on 08.06.22.
//

import UIKit

protocol PagerViewMainCollectionViewCellDelegate {
    func mustPresent(comments: [Comment])
}

class PagerViewMainCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var nameTitleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var customerNameLabel: UILabel!
    @IBOutlet weak var deliveryNameLabel: UILabel!
    @IBOutlet weak var baseLabel: UILabel!
    @IBOutlet weak var fareLabel: UILabel!
    
    @IBOutlet weak var firstCommentAuthorLabel: UILabel!
    @IBOutlet weak var fistCommentLabel: UILabel!
    
    
    var delegate: PagerViewMainCollectionViewCellDelegate?
    var taskData: TaskData?
    
    @IBAction func addCommentButton(_ sender: UIButton) {
        delegate?.mustPresent(comments: (taskData?.taskUsers?[0].comments) ?? [Comment(id: "", text: "", userID: 0, modifiedAt: "", userOutputName: "")])
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    
    func updateMainUIView(data: TaskData) {
        taskData = data
        configureUIElements(name: data.title?.de ?? "",
                            date: "\(data.taskDate ?? "nil")",
                            taskTime: "\(data.taskTime ?? "nil")" ,
                            taskEndTime: "\(data.taskEndTime ?? "nil")",
                            customer: "nil",
                            deliveryName: "nil",
                            baseText: "\(data.taskUsers?[0].supplierPriceData?.basePrice ?? 0)",
                            fareText: "nil")


        
        
        configureCommentSection(firstCommentAuthor: data.taskUsers?[0].comments?.first?.userOutputName ?? "",
                                firstComment: (data.taskUsers?[0].comments?.first?.text ?? "").removeHtmlTags())

        
        
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
    
    private func configureCommentSection(firstCommentAuthor: String, firstComment: String) {
        firstCommentAuthorLabel.text = firstCommentAuthor
        fistCommentLabel.text = firstComment
    }
}


