//
//  ScheduleDelete.swift
//  AlphaLing
//
//  Created by Gaga Nizharadze on 23.06.22.
//

import Foundation

class ScheduleDelete {
    static let shared = ScheduleDelete()
    
    func deleteApiCall(id: Int) {
        
        guard let url = URL(string: "https://alphatest.webmitplan.de/api/task/task-time-tracking/\(id)") else { return }
        
        var request = URLRequest(url: url)
    
        request.httpMethod = "DELETE"
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        request.allHTTPHeaderFields = ["Authorization" : "Bearer \(UserDefaults.standard.value(forKey: "token") ?? "nil")"]
        
        
        let task = URLSession.shared.dataTask(with: request) { data, statusCode, error in
            guard let data = data, error == nil else {
                
                return }
            
            do{
                let response = try JSONDecoder().decode(Int?.self, from: data)
                
                if let statusCode = statusCode {
                    print("delete status code:\(statusCode)")
                }
                
                if let result = response {
                    print("...\n \(result) ...\n")
                    
                }
                else {
                    
                }
            }
            catch {
                print(error)
            }
        }
        
        task.resume()
    }
}
