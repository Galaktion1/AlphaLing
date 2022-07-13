//
//  TimeTrackingViewModel.swift
//  AlphaLing
//
//  Created by Gaga Nizharadze on 17.06.22.
//

import Foundation

class TimeTrackingApiService {
    
    private var dataTask: URLSessionDataTask?
    
    
    func getTimeTrackingData(completion: @escaping (Result<[TimeTrackingModel?], Error>) -> Void) {

        let urlString = "https://alphatest.webmitplan.de/api/task/task-time-tracking"
        let parameter = ["filter": "taskId||eq||\(UserDefaults.standard.value(forKey: "taskID") ?? 0)"]
        let header = ["Authorization" : "Bearer \(UserDefaults.standard.value(forKey: "token") ?? "nil")"]

        var urlComponents = URLComponents(string: urlString)

        var queryItems = [URLQueryItem]()
        for (key, value) in parameter {
            queryItems.append(URLQueryItem(name: key, value: value))
        }

        urlComponents?.queryItems = queryItems

        var request = URLRequest(url: (urlComponents?.url)!)
        request.httpMethod = "GET"

        for (key, value) in header {
            request.setValue(value, forHTTPHeaderField: key)
        }
        
        
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
                let jsonData = try decoder.decode(TimeTracking.self, from: data)
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




