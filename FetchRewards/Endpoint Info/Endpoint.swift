//
//  Endpoint.swift
//  FetchRewards
//
//  Created by LanceMacBookPro on 11/16/22.
//

import Foundation

struct Endpoint {
    let path: String
    let queryDict: [String: String]
}

// MARK: - URLComponents
extension Endpoint {
    
    var url: URL {
        
        var components = URLComponents()
        components.scheme = APIConstants.endpointScheme
        components.host = APIConstants.endpointHost
        components.path = "\(APIConstants.endpointMainPath)\(path)"
        components.queryItems = queryDict.map{ URLQueryItem(name: $0.key, value: $0.value) }
        
        guard let compnentsURL = components.url else {
            preconditionFailure("Invalid components-url: \(components)")
        }
        
        return compnentsURL
    }
}
