//
//  SettingsAPICall.swift
//  AlphaLing
//
//  Created by Gaga Nizharadze on 09.06.22.
//

import Foundation

class LogOutAPICall {
    
    private var dataTask: URLSessionDataTask?
   
    func getResponse(completion: @escaping (Result<Bool, Error>) -> Void) {
        
        guard let url = URL(string: "https://alphatest.webmitplan.de/api/auth/logout") else { return }
        
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
                let boolData = try decoder.decode(Bool.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(boolData))
                }
            }
            catch let error {
                completion(.failure(error))
            }
        }
        dataTask?.resume()
         
    }
}
