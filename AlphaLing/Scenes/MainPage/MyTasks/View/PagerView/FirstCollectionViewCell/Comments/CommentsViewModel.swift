//
//  CommentsViewModel.swift
//  AlphaLing
//
//  Created by Gaga Nizharadze on 14.06.22.
//

import Foundation

class CommentsViewModel {
    
    static let comments = CommentsViewModel()
    
    func addComment(text: String, completionHandler: @escaping (Result<[Comment], Error>) -> Void) {
        
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
            
            if let response = response {
                print(response, "<- comment add response")
            }

            guard let data = data else {
                return
            }
            
            do{
                let jsonDecoded = try JSONDecoder().decode(CommentAddResponse.self, from: data)
                
                if let comments = jsonDecoded.taskUser?.comments {
                    completionHandler(.success(comments))
                }
            }
            catch {
                print(error)
            }
        }
        
        task.resume()
    }
    
    func deleteComment(commentId: String, completionHandler: @escaping (Result<String, Error>) -> Void) {
        
        
        guard let url = URL(string: "https://alphatest.webmitplan.de/api/task/task-users/\(UserDefaults.standard.string(forKey: "ID")!)/comments/\(commentId)") else { return }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "DELETE"
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.allHTTPHeaderFields = ["Authorization" : "Bearer \(UserDefaults.standard.value(forKey: "token") ?? "nil")"]
        
        
        let task = URLSession.shared.dataTask(with: request) { data, statusCode, error in
            guard let data = data, error == nil else {
                completionHandler(.failure(Error.self as! Error))
                return }
            
            do{
                let response = try JSONDecoder().decode(String?.self, from: data)
                
                if let statusCode = statusCode {
                    print("delete status code:\(statusCode)")
                }
                
                if let result = response {
                    print("...\n \(result) ...\n")
                    completionHandler(.success(result))
                }
                else {
                    completionHandler(.failure(APIError.incorrectValues))
                }
            }
            catch {
                print(error)
            }
        }
        
        task.resume()
    }
    
}


