//
//  CommentsViewModel.swift
//  AlphaLing
//
//  Created by Gaga Nizharadze on 14.06.22.
//

import Foundation

class CommentsViewModel {
    func apiCall(text: String, completionHandler: @escaping (Result<String, Error>) -> Void) {
        
        guard let url = URL(string: "https://alphatest.webmitplan.de/api/task/task-users/\(UserDefaults.standard.string(forKey: "taskId")!)/comments") else { return }
        
        var request = URLRequest(url: url)
    
        request.httpMethod = "POST"
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        
        let body: [String: String] = [
            "id" : UserDefaults.standard.string(forKey: "taskId")!,
            "text" : text
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
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


