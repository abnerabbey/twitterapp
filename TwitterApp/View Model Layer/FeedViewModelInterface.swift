//
//  FeedViewModelInterface.swift
//  TwitterApp
//
//  Created by Abner Castro on 18/08/20.
//  Copyright © 2020 Abner Castro. All rights reserved.
//

import Foundation

protocol FeedViewModelInterface {
    var state: Binder<State> { get set }
    subscript(index: Int) -> TweetViewModel { get }
    var tweetsCount: Int { get }
    func fetchTimeLine()
    func fetchByHashTag(_ string: String)
}

extension FeedViewModelInterface {
    func fetchTimeLine() {}
    func fetchByHashTag(_ string: String) {}
}
