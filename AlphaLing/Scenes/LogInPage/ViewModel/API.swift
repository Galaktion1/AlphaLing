//
//  API.swift
//  AlphaLing
//
//  Created by Gaga Nizharadze on 31.05.22.
//"ingrida.k@gmail.com"
// "Paswort1"

import Foundation

class APIService {
    
    func apiCall(username: String, password: String, completionHandler: @escaping (Result<String, Error>) -> Void) {
        
        guard let url = URL(string: "https://alphatest.webmitplan.de/api/auth/login") else { return }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: String] = [
            "username" : username,
                "password" : password,
                "loginScopeKey" : "desk"
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                completionHandler(.failure(Error.self as! Error))
                return }
            
            do{
                let response = try JSONDecoder().decode(SuccessfullyResponse.self, from: data)
                
                if let result = response.accessToken {
//                    print("...\n \(result) ...\n")
                    completionHandler(.success(result))
                }
                
                if let _ = response.error {
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

enum APIError: Error {
    case incorrectValues
    
}
