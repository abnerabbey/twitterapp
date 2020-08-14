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
}

extension Tweet {
    
    private enum CodingKeys: String, CodingKey {
        case creation
        case id = "id_str"
        case text
        case user
    }
    
}
