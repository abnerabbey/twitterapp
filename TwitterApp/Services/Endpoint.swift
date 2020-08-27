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
    case postTweet(Data?)
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
        case .user:
            guard let url = URL(string: Endpoint.baseURL + "/api/user") else { fatalError("Invalid URL") }
            return URLRequest(url: url)
        case .postTweet(let data):
            guard let url = URL(string: Endpoint.baseURL + "/api/statuses/update") else { fatalError("Invalid URL") }
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.httpBody = data
            request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            return request
        }
    }
}
