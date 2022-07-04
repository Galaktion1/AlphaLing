//
//  FetchDocuments.swift
//  AlphaLing
//
//  Created by Gaga Nizharadze on 28.06.22.
//

import Foundation
import UIKit

class FetchDocumentsAPICall {
    
    private var dataTask: URLSessionDataTask?
    
    
    func getFetchedDocuments(completion: @escaping (Result<[DocumentFetchingResponseModel?], Error>) -> Void) {

        let urlString = "https://alphatest.webmitplan.de/api/assets/document-files"
        let parameter = ["filter": "originId||eq||\(UserDefaults.standard.value(forKey: "taskDataID") ?? "nil")"]
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
                let jsonData = try decoder.decode(DocumentFetchingResponse.self, from: data)
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




class FetchDocumentsViewModel {
    
        
    private var apiCall = FetchDocumentsAPICall()
    var reloadTableView: (()->Void)?
    private var documents = [DocumentFetchingResponseModel?] () {
        didSet {
            self.reloadTableView?()
        }
    }
    
    func fetchDocumentsData() {
        apiCall.getFetchedDocuments { [weak self] (result) in
            switch result {
                
            case .success(let listOf):
                print("succesful retrived data")
                
//                print(listOf)
                self?.documents = listOf
            case .failure(let error):
                print("error processing json data \(error)")
            }
        }
    }
    
    func numberOfRowsInSection() -> Int {
        (documents.count != 0 ) ? documents.count : 0
    }
    
    func cellForRowAt (indexPath: IndexPath) -> DocumentFetchingResponseModel {
        documents[indexPath.section]!
    }
    
    func getActivityInfo() -> [DocumentFetchingResponseModel?] {
        documents
    }
    
    
    
    
    func requestNativeImageUpload(image: UIImage) {

        guard let url = URL(string: "https://alphatest.webmitplan.de/api/assets/document-files/upload/task/\(UserDefaults.standard.value(forKey: "taskDataID") ?? "nil")") else { return }
        let boundary = "Boundary-\(NSUUID().uuidString)"
        var request = URLRequest(url: url)

        guard let mediaImage = Media(withImage: image, forKey: "file") else { return }

        request.httpMethod = "POST"

        request.allHTTPHeaderFields = [
                    "Accept": "application/json",
                    "Content-Type": "multipart/form-data; boundary=\(boundary)",
                    "Authorization": "Bearer \(UserDefaults.standard.value(forKey: "token") ?? "nil")"
                ]

        let dataBody = createDataBody(media: [mediaImage], boundary: boundary)
        request.httpBody = dataBody

        let session = URLSession.shared
        session.dataTask(with: request) { (data, response, error) in
            if let response = response {
                print(response)
            }
            
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: [])
                    print(json)
                } catch {
                    print(error)
                }
            }
        }.resume()
    }

    func createDataBody(media: [Media]?, boundary: String) -> Data {

        let lineBreak = "\r\n"
        var body = Data()

        

        if let media = media {
            for photo in media {
                body.append("--\(boundary + lineBreak)")
                body.append("Content-Disposition: form-data; name=\"\(photo.key)\"; filename=\"\(photo.fileName)\"\(lineBreak)")
                body.append("Content-Type: \(photo.mimeType + lineBreak + lineBreak)")
                body.append(photo.data)
                body.append(lineBreak)
            }
        }

        body.append("--\(boundary)--\(lineBreak)")

        return body
    }

    struct Media {
        let key: String
        let fileName: String
        let data: Data
        let mimeType: String

        init?(withImage image: UIImage, forKey key: String) {
            self.key = key
            self.mimeType = "image/jpg"
            self.fileName = "\(arc4random()).jpeg"

            guard let data = image.jpegData(compressionQuality: 0.1) else { return nil }
            self.data = data
        }
    }
}
    
   

class FileDownloader {

    static func loadFileSync(url: URL, completion: @escaping (String?, Error?) -> Void)
    {
        let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!

        let destinationUrl = documentsUrl.appendingPathComponent(url.lastPathComponent)

        if FileManager().fileExists(atPath: destinationUrl.path)
        {
            print("File already exists [\(destinationUrl.path)]")
            completion(destinationUrl.path, nil)
        }
        else if let dataFromURL = NSData(contentsOf: url)
        {
            if dataFromURL.write(to: destinationUrl, atomically: true)
            {
                print("file saved [\(destinationUrl.path)]")
                completion(destinationUrl.path, nil)
            }
            else
            {
                print("error saving file")
                let error = NSError(domain:"Error saving file", code:1001, userInfo:nil)
                completion(destinationUrl.path, error)
            }
        }
        else
        {
            let error = NSError(domain:"Error downloading file", code:1002, userInfo:nil)
            completion(destinationUrl.path, error)
        }
    }

    static func loadFileAsync(url: URL, completion: @escaping (String?, Error?) -> Void)
    {
        let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!

        let destinationUrl = documentsUrl.appendingPathComponent(url.lastPathComponent)

        if FileManager().fileExists(atPath: destinationUrl.path)
        {
            print("File already exists [\(destinationUrl.path)]")
            completion(destinationUrl.path, nil)
        }
        else
        {
            let session = URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: nil)
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            let task = session.dataTask(with: request, completionHandler:
            {
                data, response, error in
                if error == nil
                {
                    if let response = response as? HTTPURLResponse
                    {
                        if response.statusCode == 200
                        {
                            if let data = data
                            {
                                if let _ = try? data.write(to: destinationUrl, options: Data.WritingOptions.atomic)
                                {
                                    completion(destinationUrl.path, error)
                                }
                                else
                                {
                                    completion(destinationUrl.path, error)
                                }
                            }
                            else
                            {
                                completion(destinationUrl.path, error)
                            }
                        }
                    }
                }
                else
                {
                    completion(destinationUrl.path, error)
                }
            })
            task.resume()
        }
    }
}

extension Data {
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}
