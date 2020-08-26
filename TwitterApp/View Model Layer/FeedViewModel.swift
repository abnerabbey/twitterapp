//
//  FeedViewModel.swift
//  TwitterApp
//
//  Created by Abner Castro on 14/08/20.
//  Copyright © 2020 Abner Castro. All rights reserved.
//

import Foundation

class FeedViewModel {
    
    let fetcher: AnyFetcher<[Tweet]>
    var state = Binder<State>()
    
    private var tweets = Binder<[TweetViewModel]>([])
    
    
    init(fetcher: AnyFetcher<[Tweet]>) {
        self.fetcher = fetcher
    }
    
    func fetchTimeLine() {
        state.value = .fetching
        fetcher.request(.timeline) { [weak self] result in
            switch result {
            case .success(let tweets):
                self?.tweets.value = tweets.map { TweetViewModel(tweet: $0) }
                self?.state.value = .success
            case .failure(_):
                self?.state.value = .error
                break
            }
        }
    }
}

extension FeedViewModel: FeedViewModelInterface {
    
    var flow: Flow {
        return .feed
    }
    
    subscript(index: Int) -> TweetViewModel {
        get {
            return tweets.value![index]
        }
    }
    
    var tweetsCount: Int {
        return tweets.value!.count
    }
    
}
