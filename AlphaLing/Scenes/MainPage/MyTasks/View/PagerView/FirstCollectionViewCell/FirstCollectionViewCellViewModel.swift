//
//  FirstCollectionViewCellViewModel.swift
//  AlphaLing
//
//  Created by Gaga Nizharadze on 07.07.22.
//

import Foundation

class MainViewViewModel {
    
    private var urlString = "https://alphatest.webmitplan.de/api/task/tasks/"
    
    private var dataTask: URLSessionDataTask?
    
    func acceptMyTask(id: Int, completion: @escaping (Result<String, Error>) -> Void) {
        guard let url = URL(string: "\(urlString)\(id)/complete") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
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
                let jsonData = try decoder.decode(String.self, from: data)
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
    
    func cancelMyTask(id: Int, completion: @escaping (Result<String, Error>) -> Void) {
        guard let url = URL(string: "\(urlString)\(id)/cancel") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
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
                let jsonData = try decoder.decode(String.self, from: data)
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
