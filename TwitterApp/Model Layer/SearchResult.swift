//
//  SearchResult.swift
//  TwitterApp
//
//  Created by Abner Castro on 18/08/20.
//  Copyright © 2020 Abner Castro. All rights reserved.
//

import Foundation

struct SearchResult: Codable {
    var tweets: [Tweet]
}

extension SearchResult {
    
    private enum CodingKeys: String, CodingKey {
        case tweets = "statuses"
    }
    
}
