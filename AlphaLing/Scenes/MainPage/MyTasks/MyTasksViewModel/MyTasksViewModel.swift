//
//  MyTasksViewModel.swift
//  AlphaLing
//
//  Created by Gaga Nizharadze on 01.06.22.
//

import Foundation
import UIKit

class TaskApiService {
    
    private var dataTask: URLSessionDataTask?
    
    let linkSnippet: String
    
    init(linkSnippet: String) {
        self.linkSnippet = linkSnippet
    }
    
    
    func getMyTasksData(myTaskView: UIView, completion: @escaping (Result<TaskModel, Error>) -> Void) {
        
        guard let url = URL(string: "https://alphatest.webmitplan.de/api/task/tasks/\(linkSnippet)") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        request.allHTTPHeaderFields = ["Authorization" : "Bearer \(UserDefaults.standard.value(forKey: "token") ?? "nil")"]
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        ActivityView.shared.showActivity(myView: myTaskView, myTitle: "Loading...")
        dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                DispatchQueue.main.async {
                    ActivityView.shared.removeActivity(myView: myTaskView)
                }
                
                
                
                completion(.failure(error))
                print("error -> \(error)")
            }
            
            guard let response = response as? HTTPURLResponse else {
                
                
                print("Empty Response")
                return
            }
            print("Response status code: \(response.statusCode)")
            
            guard let data = data else {
                DispatchQueue.main.async {
                    ActivityView.shared.removeActivity(myView: myTaskView)
                }
                print("Empty data")
                return
            }
            
            do {
                
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(TaskModel.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                    ActivityView.shared.removeActivity(myView: myTaskView)
                }
            }
            catch let error {
                DispatchQueue.main.async {
                    ActivityView.shared.removeActivity(myView: myTaskView)
                }
                completion(.failure(error))
            }
            
            
        }
        dataTask?.resume()
    }
}




class MyTasksViewModel {
    
        
    private var apiService = TaskApiService(linkSnippet: "my")
    var reloadTableView: (()->Void)?
    var userInfo = [TaskData](){
        didSet {
            self.reloadTableView?()
        }
    }
    
    func fetchMyTasksData(myTastView: UIView) {
        apiService.getMyTasksData(myTaskView: myTastView) { [weak self] (result) in
            switch result {
            case .success(let listOf):
                print("succesful retrived data")
                guard let data = listOf.data else { return }
                self?.userInfo = data
            case .failure(let error):
                print("error processing json data \(error)")
            }
        }
    }
    
    func numberOfRowsInSection() -> Int {
        (userInfo.count != 0 ) ? userInfo.count : 0
    }
    
    func activeButton(button: UIButton, button1: UIButton, button2: UIButton) {
        button.tintColor = UIColor(named: "specialBlue")
        
        button1.tintColor = .gray
        button2.tintColor = .gray
    }
    

    func moveActiviveIndicatorView(point: CGFloat, indicatorView: UIView) {
        UIView.animate(withDuration: 0.2, delay: 0.0, options:[], animations: {
            indicatorView.transform = CGAffineTransform(translationX: point, y: 0)
            }, completion: nil)
    }
    
    func cellForRowAt (indexPath: IndexPath) -> TaskData {
        let taskData = userInfo[indexPath.section]
        UserDefaults.standard.set(taskData.taskUsers?[0].id, forKey: "ID")
        
        UserDefaults.standard.set(taskData.taskUsers?[0].taskID, forKey: "taskID")
        
        UserDefaults.standard.set(taskData.id, forKey: "taskDataID")
        
        return taskData
    }
    
    func switchResult(result: Result<Int, Error>, fileType: String, viewController: UIViewController, cell: UICollectionViewCell) {
        
        switch result {
        case .success(_):
            DispatchQueue.main.async {
                
                switch result {
                case .success(_):
                    let casted = cell as! DocumentsCollectionViewCell
                    casted.fetchDocumentsData()
                    
                case .failure(let err):
                    print("error while uploading file", err)
                }
                
                viewController.showAlert(alertText: "SUCCESS", alertMessage: "\(fileType) was successfully uploaded", addActionTitle: "Done")
            }
        case .failure(let error):
            DispatchQueue.main.async {
                viewController.showAlert(alertText: "FAIL", alertMessage: "\(error)", addActionTitle: "Done")
            }
        }
    }
    
    
}

