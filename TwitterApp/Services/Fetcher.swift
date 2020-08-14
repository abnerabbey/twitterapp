//
//  Fetcher.swift
//  TwitterApp
//
//  Created by Abner Castro on 14/08/20.
//  Copyright © 2020 Abner Castro. All rights reserved.
//

import Foundation

protocol Fetcher {
    associatedtype Model
    
    func request(_ endpoint: Endpoint, completion: @escaping (Result<Model, Error>) -> ())
}

struct AnyFetcher<T: Codable>: Fetcher {
    
    private let _request: (_: Endpoint, _: @escaping(Result<T, Error>) -> ()) -> ()
    
    init<U: Fetcher>(fetcher: U) where U.Model == T {
        self._request = fetcher.request
    }
    
    func request(_ endpoint: Endpoint, completion: @escaping (Result<T, Error>) -> ()) {
        _request(endpoint, completion)
    }
    
}
