//
//  TimeTrackingViewModel.swift
//  AlphaLing
//
//  Created by Gaga Nizharadze on 17.06.22.
//

import Foundation

class TimeTrackingApiService {
    
    private var dataTask: URLSessionDataTask?
    
    
    func getTimeTrackingData(completion: @escaping (Result<TimeTrackingModel?, Error>) -> Void) {
        
        guard var url = URL(string: "https://alphatest.webmitplan.de/api/task/task-time-tracking") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        request.allHTTPHeaderFields = ["Authorization" : "Bearer \(UserDefaults.standard.value(forKey: "token") ?? "nil")"]
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
//        var components = URLComponents(
//            url: url,
//            resolvingAgainstBaseURL: false
//        )!
//
//        // URL query parameters as a dictionary
//        components.queryItems = [URLQueryItem(name: "filter", value: "taskId||eq||6")]
//
//        print(components.string!)
        url.appendQueryItem(name: "filter", value: "taskId||eq||6")
        
        print(url)
        
        
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
                let jsonData = try decoder.decode(TimeTrackingModel.self, from: data)
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




class TimeTrackingViewModel {
    
        
    private var apiService = TimeTrackingApiService()
    var reloadTableView: (()->Void)?
    private var userInfo = [TimeTrackingModel] ()
    
    func fetchTimeTrackingData() {
        apiService.getTimeTrackingData { [weak self] (result) in
            switch result {
                
            case .success(let listOf):
                print("succesful retrived data")
                guard let data = listOf else { return }
                print(listOf ?? "aranairi araferi")
                self?.userInfo.append(data)
            case .failure(let error):
                print("error processing json data \(error)")
            }
        }
    }
    
    func numberOfRowsInSection() -> Int {
        (userInfo.count != 0 ) ? userInfo.count : 0
    }
    
    func cellForRowAt (indexPath: IndexPath) -> TimeTrackingModel {
        userInfo[indexPath.row]
    }
}









extension URL {

    mutating func appendQueryItem(name: String, value: String?) {

        guard var urlComponents = URLComponents(string: absoluteString) else { return }

        // Create array of existing query items
        var queryItems: [URLQueryItem] = urlComponents.queryItems ??  []

        // Create query item
        let queryItem = URLQueryItem(name: name, value: value)

        // Append the new query item in the existing query items array
        queryItems.append(queryItem)

        // Append updated query items array in the url component object
        urlComponents.queryItems = queryItems

        // Returns the url from new url components
        self = urlComponents.url!
    }
}
