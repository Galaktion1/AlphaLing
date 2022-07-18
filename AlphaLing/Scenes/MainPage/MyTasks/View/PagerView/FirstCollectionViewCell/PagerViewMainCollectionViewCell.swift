//
//  PagerViewMainCollectionViewCell.swift
//  AlphaLing
//
//  Created by Gaga Nizharadze on 08.06.22.
//

import UIKit

protocol PagerViewMainCollectionViewCellDelegate {
    func mustPresent(comments: [Comment])
    func askSomethingWithAlert(alertText: String,
                               alertMessage: String,
                               actionTitle: String,
                               action: ((UIAlertAction) -> Void)?)
    
    func dismiss()
}


class PagerViewMainCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var nameTitleLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var customerNameLabel: UILabel!
   
    
    @IBOutlet weak var baseLabel: UILabel!
    @IBOutlet weak var fareLabel: UILabel!
    @IBOutlet weak var firstCommentAuthorLabel: UILabel!
    @IBOutlet weak var fistCommentLabel: UILabel!
    @IBOutlet weak var seeMoreLabel: UILabel!
    
    var delegate: PagerViewMainCollectionViewCellDelegate?
    var taskData: TaskData?
    
    let viewModel = MainViewViewModel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.scrollView.contentSize.height = 1.0
        // Initialization code
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.tapFunction))
        seeMoreLabel.isUserInteractionEnabled = true
        seeMoreLabel.addGestureRecognizer(tap)
    }
    
    @IBAction func addCommentButton(_ sender: UIButton) {
        guard let comment = taskData?.taskUsers?.first?.comments else { return }
        
        delegate?.mustPresent(comments: comment)
    }
        
    
    
    @IBAction func completeTaskButton(_ sender: UIButton) {
        guard let id = taskData?.id else { return }
        
        self.delegate?.askSomethingWithAlert(alertText: "Task Accept", alertMessage: "Do you want to complete this task?", actionTitle: "complete") { _ in
            
            self.viewModel.acceptMyTask(id: id) { _ in
                print("Task Accepted succesfully")
                self.delegate?.dismiss()
            }
        }
        
    }
    
    @IBAction func cancelTaskButton(_ sender: UIButton) {
        guard let id = taskData?.id else { return }
        
        self.delegate?.askSomethingWithAlert(alertText: "Task Rejection", alertMessage: "Do you want to cancel this task?", actionTitle: "Yes") { _ in
            self.viewModel.cancelMyTask(id: id) {  _ in
                print("Task rejected succesfully")
                self.delegate?.dismiss()
            }
        }
    }
    
//    ingrida.k@gmail.com   alpha48145
    
    
    @objc func tapFunction(sender:UITapGestureRecognizer) {
        delegate?.mustPresent(comments: (taskData?.taskUsers?[0].comments) ?? [Comment(id: "", text: "", userID: 0, modifiedAt: "", userOutputName: "")])
    }
    
    
    func updateMainUIView(data: TaskData) {
        taskData = data
        configureUIElements(name: data.title?.de ?? "",
                            date: "\(data.taskDate ?? "nil")",
                            taskTime: "\(data.taskTime ?? "nil")" ,
                            taskEndTime: "\(data.taskEndTime ?? "nil")",
                            customer: "\(data.descriptions?.autoDefault?.de?.removeHtmlTags() ?? "")",
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
                             baseText: String,
                             fareText: String) {
        
        nameTitleLabel?.text = name
        dateLabel?.text = date
        timeLabel?.text = "\(taskTime.prefix(5)) - \(taskEndTime.prefix(5))"
        customerNameLabel?.text = customer
        baseLabel?.text = baseText
        fareLabel?.text = fareText

    }
    
    private func configureCommentSection(firstCommentAuthor: String, firstComment: String) {
        firstCommentAuthorLabel.text = firstCommentAuthor
        fistCommentLabel.text = firstComment
    }
}


