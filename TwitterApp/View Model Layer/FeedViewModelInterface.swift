//
//  FeedViewModelInterface.swift
//  TwitterApp
//
//  Created by Abner Castro on 18/08/20.
//  Copyright © 2020 Abner Castro. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

protocol FeedViewModelInterface {
    var state: PublishSubject<State> { get set }
    var flow: Flow { get }
    subscript(index: Int) -> TweetViewModel { get }
    var tweetsCount: Int { get }
    func fetchTimeLine()
    func fetchByHashTag(_ string: String)
}

extension FeedViewModelInterface {
    func fetchTimeLine() {}
    func fetchByHashTag(_ string: String) {}
}
