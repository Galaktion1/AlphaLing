//
//  FileUploadAPICall.swift
//  AlphaLing
//
//  Created by Gaga Nizharadze on 01.07.22.
//

import Foundation
import UniformTypeIdentifiers

class FileUploadAPICall {
    static let shared = FileUploadAPICall()
    
    func uploadDocumentRequest(url: URL, completionHandler: @escaping (Result<Int, Error>) -> Void)
        {
            let boundary = "Boundary-\(NSUUID().uuidString)"

            var body = Data()

            let filePathKey = "file"
            let filename = "\(arc4random())"
            let fileData: Data = try! Data(contentsOf: url)
            let mimetype = "application/pdf"
            
            let lineBreak = "\r\n"

            body.append("--\(boundary + lineBreak)")
            body.append(Data("Content-Disposition: form-data; name=\"\(filePathKey)\"; filename=\"\(filename)\"\r\n".utf8))
            body.append("Content-Type: \(mimetype + lineBreak + lineBreak)")
            body.append(fileData)
            body.append(lineBreak)
            body.append("--\(boundary)--\(lineBreak)")


            guard let url = URL(string: "https://alphatest.webmitplan.de/api/assets/document-files/upload/task/\(UserDefaults.standard.value(forKey: "taskDataID") ?? "nil")") else { return }
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.allHTTPHeaderFields = [
                        "Accept": "application/json",
                        "Content-Type": "multipart/form-data; boundary=\(boundary)",
                        "Authorization": "Bearer \(UserDefaults.standard.value(forKey: "token") ?? "nil")"
                    ]
            request.httpBody = body

            let session = URLSession.shared
            
            session.dataTask(with: request) { (data, response, error) in
                if let response = response {
                    print(response)
                }

                if let data = data {
                    do {
                        let json = try JSONDecoder().decode(TimeTrackingModel.self, from: data)
                        print(json)
                        completionHandler(.success(1))
                        
                    } catch {
                        print(error)
                        completionHandler(.failure(error))
                    }
                }
            }.resume()
        }
}

