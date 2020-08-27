//
//  PostTweet.swift
//  TwitterApp
//
//  Created by Abner Castro on 27/08/20.
//  Copyright © 2020 Abner Castro. All rights reserved.
//

import Foundation

struct PostTweet: Codable {
    var status: String
}

struct PostTweetResponse: Codable {
    let code: String
    let message: String
}
