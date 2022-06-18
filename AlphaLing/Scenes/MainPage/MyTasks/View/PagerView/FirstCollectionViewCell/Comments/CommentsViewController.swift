//
//  CommentsViewController.swift
//  AlphaLing
//
//  Created by Gaga Nizharadze on 14.06.22.
//

import UIKit

class CommentsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var comments: [Comment]?

    @IBOutlet weak var commentTextField: UITextField!
    
    let viewModel = CommentsViewModel()
    
    @IBAction func commentButton(_ sender: UIButton) {
        
        if let comment = commentTextField.text{
            commentTextField.text = nil
            if comment.count > 0 {
                viewModel.apiCall(text: comment) { result in
                    print(result)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                        self.tableView.reloadData()
                    }
                
                }
            }
        }
        

        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        
        tableView.register(CommentsTableViewCell.nib(), forCellReuseIdentifier: CommentsTableViewCell.identifier)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

        // Do any additional setup after loading the view.
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
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentsTableViewCell", for: indexPath) as! CommentsTableViewCell
        
        
        
        cell.authorLabel.text = comments?[indexPath.row].userOutputName ?? ""
        cell.messageTextLabel.text = (comments?[indexPath.row].text ?? "").removeHtmlTags()

        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        comments?.count ?? 0
        
    }
    
    
    
}



