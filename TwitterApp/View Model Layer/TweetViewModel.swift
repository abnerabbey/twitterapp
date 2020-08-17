//
//  TweetViewModel.swift
//  TwitterApp
//
//  Created by Abner Castro on 14/08/20.
//  Copyright © 2020 Abner Castro. All rights reserved.
//

import Foundation

protocol TweetViewModelable {
    
    var text: String { get }
    var creation: String { get }
    var user: UserViewModelable { get }
    
}

struct TweetViewModel: TweetViewModelable {
    
    var text: String {
        return tweet.text
    }
    
    var creation: String {
        return tweet.creation
    }
    
    var user: UserViewModelable {
        return UserViewModel(user: tweet.user)
    }
    
    private let tweet: Tweet
    
    init(tweet: Tweet) {
        self.tweet = tweet
    }
    
}
