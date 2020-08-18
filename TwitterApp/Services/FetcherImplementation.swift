//
//  FetcherImplementation.swift
//  TwitterApp
//
//  Created by Abner Castro on 14/08/20.
//  Copyright © 2020 Abner Castro. All rights reserved.
//

import Foundation

class FetcherImplementation<T: Codable>: Fetcher {
    typealias Model = T
    
    func request(_ endpoint: Endpoint, completion: @escaping (Result<Model, Error>) -> ()) {
        
        let request = endpoint.request
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let data = data else { completion(.failure(APIErrors.err("No data")))
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(Model.self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        .resume()
    }
}
