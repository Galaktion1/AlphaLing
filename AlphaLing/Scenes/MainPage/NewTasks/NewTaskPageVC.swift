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
    
    @IBOutlet weak var bottomButtonsStackView: UIStackView!
    
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
    
    @IBAction func newTaskCountOfferButton(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Login",
                                                message: nil,
                                                preferredStyle: .alert)
        
        alertController.addTextField { (textField) in
            textField.placeholder = "supplierOfferPrice"
        }
        
        alertController.addTextField { (textField) in
            textField.placeholder = "SupplierOfferTravelPrice"
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
    
    
    
    var data: TaskData?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        guard let data = data else { return }
        updateMainUIView(data: data)
    }
    
    func updateMainUIView(data: TaskData) {
        
        configureUIElements(name: data.title?.de ?? "nil",
                            date: "\(data.taskDate ?? "")",
                            taskTime: "\(data.taskTime ?? "")",
                            taskEndTime: "\(data.taskEndTime ?? "")",
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
