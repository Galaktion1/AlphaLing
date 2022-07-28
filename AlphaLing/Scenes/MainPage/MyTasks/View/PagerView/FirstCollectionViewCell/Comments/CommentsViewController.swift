//
//  CommentsViewController.swift
//  AlphaLing
//
//  Created by Gaga Nizharadze on 14.06.22.
//

import UIKit


class CommentsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var commentTextField: UITextField!
    
    let viewModel = CommentsViewModel()
    
    var comments: [Comment]? {
        didSet {
            self.tableView?.reloadData()
        }
    }
    
    var model: TaskModel!
    {
        didSet {
            let currentSection = UserDefaults.standard.integer(forKey: "numberOfSectionTappedInMyTask")
            comments = model.data?[currentSection].taskUsers?[0].comments
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        self.addDoneButtonOnKeyboard()
        
        
        tableView.register(CommentsTableViewCell.nib(), forCellReuseIdentifier: CommentsTableViewCell.identifier)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
  
    
   
    
    @IBAction func commentButton(_ sender: UIButton) {
        
       
        if let comment = commentTextField.text{
            
            if comment.count > 0 {
                
                viewModel.addComment(text: comment) { result in
                    switch result {
                    case .success(let commentsArray):
                        DispatchQueue.main.async {
                            self.comments = commentsArray
                        }
                        
                    case .failure(let error):
                        print(error)
                    }
            
                }

                self.tableView.reloadData()
                view.endEditing(true)
    
                commentTextField.text = nil
            }
        }
    }

    
    func reloadDataForMyTask() {
        let vm = TaskApiService(linkSnippet: "my")
        
        vm.getMyTasksData(myTaskView: self.view) { result in
            switch result {
            case .success(let taskModel):
                self.model = taskModel
            case .failure(let error):
                print("error while getMyTaskForComments: \(error)")
            }
        }
    }
    
    func reloadDataForNewTask() {
        let vm = TaskApiService(linkSnippet: "my-new")
        
        vm.getMyTasksData(myTaskView: self.view) { result in
            switch result {
            case .success(let taskModel):
                self.model = taskModel
            case .failure(let error):
                print("error while getMyTaskForComments: \(error)")
            }
        }
    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        self.dismiss(animated: true)
//    }
    
    
    private func addDoneButtonOnKeyboard(){
            let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
            doneToolbar.barStyle = .default

            let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(self.doneButtonAction))

            let items = [flexSpace, done]
            doneToolbar.items = items
            doneToolbar.sizeToFit()

            commentTextField.inputAccessoryView = doneToolbar
        }

        @objc func doneButtonAction(){
            commentTextField.resignFirstResponder()
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100.0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        comments?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    // Set the spacing between sections
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        15
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentsTableViewCell", for: indexPath) as! CommentsTableViewCell
        
        cell.authorLabel.text = comments?[indexPath.section].userOutputName ?? ""
        cell.messageTextLabel.text = (comments?[indexPath.section].text ?? "").removeHtmlTags()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {

            guard let id = comments?[indexPath.section].id else { return }
            
            self.tableView.reloadData()
            
            self.comments?.remove(at: indexPath.section)
            
            viewModel.deleteComment(commentId: id) { result in
                switch result {
                case .success(let random):
                    print(random)
                    
                case .failure(let error):
                    print("error while deleting \(error)")
                }
            }
        }
    }
    
    
    
}



