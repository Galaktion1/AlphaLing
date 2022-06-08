//
//  MyTasksApiParser.swift
//  AlphaLing
//
//  Created by Gaga Nizharadze on 01.06.22.
//

import Foundation


class MyTaskApiService {
    
    private var dataTask: URLSessionDataTask?
    
    
    func getMyTasksData(completion: @escaping (Result<MyTasksModel, Error>) -> Void) {
        
        guard let url = URL(string: "https://alphatest.webmitplan.de/api/task/tasks/my") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
//        print(["Authorization" : "Bearer \(UserDefaults.standard.value(forKey: "token") ?? "nil")"])
        
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
                let jsonData = try decoder.decode(MyTasksModel.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(jsonData))
                    print(jsonData)
                }
            }
            catch let error {
                completion(.failure(error))
            }

            
        }
        
        dataTask?.resume()
                       
        
            
    }
}
