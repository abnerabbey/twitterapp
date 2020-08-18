//
//  Endpoint.swift
//  TwitterApp
//
//  Created by Abner Castro on 14/08/20.
//  Copyright © 2020 Abner Castro. All rights reserved.
//

import Foundation

enum Endpoint {
    static let baseURL = "https://wizetwitterproxy.herokuapp.com"
    
    case timeline
    case user
    case search(String)
}

extension Endpoint {
    
    var request: URLRequest {
        
        switch self {
        case .timeline:
            guard let url = URL(string: Endpoint.baseURL + "/api/statuses/user_timeline") else { fatalError("Invalid URL") }
            return URLRequest(url: url)
        case .search(let string):
            guard let url = URL(string: Endpoint.baseURL + "/api/search/\(string)") else { fatalError("Invalid URL") }
            return URLRequest(url: url)
        default:
            fatalError("Not implemented")
            break
        }
    }
}
