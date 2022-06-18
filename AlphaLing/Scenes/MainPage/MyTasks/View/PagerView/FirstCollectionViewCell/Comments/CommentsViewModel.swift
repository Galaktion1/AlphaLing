//
//  CommentsViewModel.swift
//  AlphaLing
//
//  Created by Gaga Nizharadze on 14.06.22.
//

import Foundation

class CommentsViewModel {
    func apiCall(text: String, completionHandler: @escaping (Result<String, Error>) -> Void) {
        
        guard let url = URL(string: "https://alphatest.webmitplan.de/api/task/task-users/\(UserDefaults.standard.string(forKey: "ID")!)/comments") else { return }
        
        var request = URLRequest(url: url)
    
        request.httpMethod = "POST"
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        let body: [String: String] = [
            "id" : UUID().uuidString,
            "text" : "<p>\(text)</p>"
        ]
        
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        
        request.allHTTPHeaderFields = ["Authorization" : "Bearer \(UserDefaults.standard.value(forKey: "token") ?? "nil")"]
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let response = response else {
                return
            }
            print(response)

            guard let data = data, error == nil else {
                completionHandler(.failure(Error.self as! Error))
                return }
            
            do{
                let response = try JSONDecoder().decode(TaskUser.self, from: data)
                
                if let result = response.status {
//                    print("...\n \(result) ...\n")
                    completionHandler(.success(result))
                    
                }
               
            }
            catch {
                print(error)
            }
        }
        
        task.resume()
    }
}


