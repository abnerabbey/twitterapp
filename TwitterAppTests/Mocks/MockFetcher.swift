//
//  MockFetcher.swift
//  TwitterAppTests
//
//  Created by Abner Castro on 17/08/20.
//  Copyright © 2020 Abner Castro. All rights reserved.
//

import Foundation
@testable import TwitterApp

final class MockFetcher<T: Codable>: Fetcher {
    typealias Model = T
    
    private var completClosure: ((Result<Model, Error>) -> ())!
    
    func request(_ endpoint: Endpoint, completion: @escaping (Result<Model, Error>) -> ()) {
        completClosure = completion
    }
    
    func fetchFail(error: APIErrors) {
        
    }
}
