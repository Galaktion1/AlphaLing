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
    @IBOutlet weak var baseLabel: UILabel!
    @IBOutlet weak var fareLabel: UILabel!
    @IBOutlet weak var firstCommentAuthorLabel: UILabel!
    @IBOutlet weak var fistCommentLabel: UILabel!
    @IBOutlet weak var bottomButtonsStackView: UIStackView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var data: TaskData?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.scrollView.contentSize.height = 1.0
        view.backgroundColor = .white
        guard let data = data else { return }
        updateMainUIView(data: data)
        if data.taskUsers?[0].status == "offer" {
            bottomButtonsStackView.arrangedSubviews.forEach { $0.removeFromSuperview()
                self.showAlert(alertText: "ABOUT TASK", alertMessage: "THIS TASK HAS OFFER STATUS", addActionTitle: "OK")
            }
        }
        
    }
    
    
    @IBAction func newTaskAcceptButton(_ sender: UIButton) {
        let apiCall = NewTaskAcceptAPICall()
        apiCall.getMyTasksData(acceptedID: data?.taskUsers?[0].id ?? -1, linkSnippet: "accept-task") { result in
            switch result {
                
            case .success(_):
                print("task succesfully accepted")
                self.navigationController?.popToRootViewController(animated: true)
                
            case .failure(let fail):
                print(fail)
            }
        }
    }
    
    private func modifyTextField(textField: UITextField, placeHolder: String) {
        textField.placeholder = placeHolder
        textField.keyboardType = .decimalPad
    }
    
    @IBAction func newTaskCountOfferButton(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Count Offer",
                                                message: nil,
                                                preferredStyle: .alert)
        
        alertController.addTextField { (textField) in
            self.modifyTextField(textField: textField, placeHolder: "supplierOfferPrice")
        }
        
        alertController.addTextField { (textField) in
            self.modifyTextField(textField: textField, placeHolder: "SupplierOfferTravelPrice")
        }
        
        let continueAction = UIAlertAction(title: "Continue",
                                           style: .default) { [weak alertController] _ in
                                            guard let textFields = alertController?.textFields else { return }
                                            
                                            guard let supplierOfferPrice = textFields[0].text,
                                                  let supplierOfferTravelPrice = textFields[1].text  else { return }
                                                
            let apiCall = TaskCountOfferAPICall()
            apiCall.countOfferApiCall(id: self.data?.taskUsers?[0].id ?? -1, supplierOfferPriceData: Double(supplierOfferPrice) ?? 0.0, supplierOfferTravelPriceData: Double(supplierOfferTravelPrice) ?? 0.0) { result in
                switch result {
                    
                case .success(let res):
                    print(res)
                    DispatchQueue.main.async {
                        self.navigationController?.popToRootViewController(animated: true)
                    }
                    
                case .failure(let error):
                    print(error)
                    
                }
            }
        }
        
        alertController.addAction(continueAction)
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (_) in
            print("User click Dismiss button")
        }))
        
        self.present(alertController, animated: true)
    }
    
    
    @IBAction func newTaskRejectButton(_ sender: UIButton) {
        
    }
    
    
    func updateMainUIView(data: TaskData) {
        
        configureUIElements(name: data.title?.de ?? "nil",
                            date: "\(data.taskDate ?? "")",
                            taskTime: "\(data.taskTime ?? "")",
                            taskEndTime: "\(data.taskEndTime ?? "")",
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
