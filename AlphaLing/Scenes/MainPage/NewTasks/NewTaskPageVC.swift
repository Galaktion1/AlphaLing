//
//  NewTaskPageVC.swift
//  AlphaLing
//
//  Created by Gaga Nizharadze on 06.06.22.
//

import UIKit

class NewTaskPageVC: UIViewController {
    
    @IBOutlet weak var nameTitleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var customerNameLabel: UILabel!
    @IBOutlet weak var deliveryNameLabel: UILabel!
    @IBOutlet weak var baseLabel: UILabel!
    @IBOutlet weak var fareLabel: UILabel!
    
    @IBOutlet weak var firstCommentAuthorLabel: UILabel!
    @IBOutlet weak var fistCommentLabel: UILabel!
    
    
    var data: TaskData?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        guard let data = data else { return }
        updateMainUIView(data: data)
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
        
//        let commentsWithoutHTMLTags = (data.taskUsers?[0].comments?.first?.text ?? "").replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        
        configureCommentSection(firstCommentAuthor: data.taskUsers?[0].comments?.first?.userOutputName ?? "",
                                firstComment: (data.taskUsers?[0].comments?.first?.text ?? "").removeHtmlTags())
        
        if UserDefaults.standard.value(forKey: "taskId") == nil {
            
            if let taskId = data.taskUsers?[0].taskID {
                UserDefaults.standard.set(taskId, forKey: "taskId")
                print(taskId)
            }
        }
        
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
