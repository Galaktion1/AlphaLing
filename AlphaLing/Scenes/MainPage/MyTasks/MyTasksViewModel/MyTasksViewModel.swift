//
//  MyTasksViewModel.swift
//  AlphaLing
//
//  Created by Gaga Nizharadze on 01.06.22.
//

import Foundation

class TaskApiService {
    
    private var dataTask: URLSessionDataTask?
    
    let linkSnippet: String
    
    init(linkSnippet: String) {
        self.linkSnippet = linkSnippet
    }
    
    
    func getMyTasksData(completion: @escaping (Result<TaskModel, Error>) -> Void) {
        
        guard let url = URL(string: "https://alphatest.webmitplan.de/api/task/tasks/\(linkSnippet)") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        request.allHTTPHeaderFields = ["Authorization" : "Bearer \(UserDefaults.standard.value(forKey: "token") ?? "nil")"]
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                print("error -> \(error)")
            }
            
            guard let response = response as? HTTPURLResponse else {
                print("Empty Response")
                return
            }
            print("Response status code: \(response.statusCode)")
            
            guard let data = data else {
                print("Empty data")
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(TaskModel.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                }
            }
            catch let error {
                completion(.failure(error))
            }
            
            
        }
        dataTask?.resume()
    }
}




class MyTasksViewModel {
    
        
    private var apiService = TaskApiService(linkSnippet: "my")
    var reloadTableView: (()->Void)?
    private var userInfo = [TaskData](){
        didSet {
            self.reloadTableView?()
        }
    }
    
    func fetchMyTasksData() {
        apiService.getMyTasksData { [weak self] (result) in
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
    
    func cellForRowAt (indexPath: IndexPath) -> TaskData {
        userInfo[indexPath.section]
    }
}

