//
//  TaskCountOfferAPICall.swift
//  AlphaLing
//
//  Created by Gaga Nizharadze on 24.06.22.
//

import Foundation

class TaskCountOfferAPICall {
    
    static let shared = TaskCountOfferAPICall()

    func countOfferApiCall(id: Int, supplierOfferPriceData: Double, supplierOfferTravelPriceData: Double,
                      completionHandler: @escaping (Result<TimeTrackingModel, Error>) -> Void) {
        
        guard let url = URL(string: "https://alphatest.webmitplan.de/api/task/task-users/\(id)/supplier-offer") else { return }
        
        var request = URLRequest(url: url)
    
        request.httpMethod = "POST"
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String : [String : Double]] = [
            "supplierOfferPriceData": [ "basePrice": supplierOfferPriceData ],
            "supplierOfferTravelPriceData" : [ "basePrice" : supplierOfferTravelPriceData ]
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        
        request.allHTTPHeaderFields = ["Authorization" : "Bearer \(UserDefaults.standard.value(forKey: "token") ?? "nil")"]
        
        
        let task = URLSession.shared.dataTask(with: request) { data, statusCode, error in
            guard let data = data, error == nil else {
                completionHandler(.failure(Error.self as! Error))
                return }
            
            do{
                let response = try JSONDecoder().decode(TimeTrackingModel?.self, from: data)
                
                if let statusCode = statusCode {
                    print("patch status code:\(statusCode)")
                }
                
                if let result = response {
                    //                    print("...\n \(result) ...\n")
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
