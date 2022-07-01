//
//  CommentsViewController.swift
//  AlphaLing
//
//  Created by Gaga Nizharadze on 14.06.22.
//

import UIKit


class CommentsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var commentAddResponse: (() -> Void)?

    var comments: [Comment]? {
        didSet {
            self.tableView?.reloadData()
        }
    }
    
    var newComment: Comment?
    
    @IBOutlet weak var commentTextField: UITextField!
    
    let viewModel = CommentsViewModel()
    
    @IBAction func commentButton(_ sender: UIButton) {
        
        if let comment = commentTextField.text{
            commentTextField.text = nil
            if comment.count > 0 {
                viewModel.apiCall(text: comment) { [self] result in
                    print(result)
                    
                    newComment = Comment(id: (UserDefaults.standard.value(forKey: "ID") as? String) , text: commentTextField.text ?? "", userID: UserDefaults.standard.value(forKey: "taskID") as? Int , modifiedAt: "", userOutputName: "Me")
                  
                }
            }
        }
        

        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        
        
        tableView.register(CommentsTableViewCell.nib(), forCellReuseIdentifier: CommentsTableViewCell.identifier)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

        if let newComment = newComment {
            self.comments?.append(newComment)
        }
    }



    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }

}

extension CommentsViewController: UITableViewDelegate, UITableViewDataSource {
    
    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentsTableViewCell", for: indexPath) as! CommentsTableViewCell
//
//        cell.authorLabel.text = comments?[indexPath.row].userOutputName ?? ""
//        cell.messageTextLabel.text = (comments?[indexPath.row].text ?? "").removeHtmlTags()
//
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        comments?.count ?? 0
//
//    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100.0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        comments?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    // There is just one row in every section
    
    
    // Set the spacing between sections
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        15
    }
    
    // Make the background color show through
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = UIView()
//        headerView.backgroundColor = UIColor.clear
//        return headerView
//    }
    
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentsTableViewCell", for: indexPath) as! CommentsTableViewCell
        
        cell.authorLabel.text = comments?[indexPath.section].userOutputName ?? ""
        cell.messageTextLabel.text = (comments?[indexPath.section].text ?? "").removeHtmlTags()
        
        return cell
    }
    
    
    
}



