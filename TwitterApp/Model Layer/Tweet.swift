//
//  Tweet.swift
//  TwitterApp
//
//  Created by Abner Castro on 14/08/20.
//  Copyright © 2020 Abner Castro. All rights reserved.
//

import Foundation

struct Tweet: Codable {
    
    let creation: String
    let id: String
    let text: String
    let user: User
    let favs: Int
    let retweets: Int
}

extension Tweet {
    
    private enum CodingKeys: String, CodingKey {
        case creation = "created_at"
        case id = "id_str"
        case text
        case user
        case favs = "favorite_count"
        case retweets = "retweet_count"
    }
    
}
