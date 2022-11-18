//
//  Service.swift
//  FetchRewards
//
//  Created by LanceMacBookPro on 11/16/22.
//

import UIKit

final class Service {
    
    static let shared = Service()
    
    private init() { }
}

enum SessionError: Error {
    case invalid(Error)
    case responseStatusCodeError(Int)
    case dataIsNil
    case malformedData(Error)
}

// MARK: - Fetch API Data
extension Service {
    
    func fetchData(with url: URL, completion: @escaping (Result<Data, SessionError>)->Void) {
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                completion(.failure(.invalid(error)))
                return
            }
            
            if let response = response as? HTTPURLResponse {
                
                guard 200..<300 ~= response.statusCode else {
                    completion(.failure(.responseStatusCodeError(response.statusCode)))
                    return
                }
            }
            
            guard let data = data else {
                completion(.failure(.dataIsNil))
                return
            }
            
            completion(.success(data))
            
        }.resume()
    }
}
