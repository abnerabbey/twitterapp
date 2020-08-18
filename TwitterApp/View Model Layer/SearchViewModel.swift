//
//  SearchViewModel.swift
//  TwitterApp
//
//  Created by Abner Castro on 18/08/20.
//  Copyright © 2020 Abner Castro. All rights reserved.
//

import Foundation

final class SearchViewModel {
    
    private let fetcher: AnyFetcher<SearchResult>
    private var tweets = Binder<[TweetViewModel]>([])
    
    var state: Binder<State> = Binder(nil)
    
    init(fetcher: AnyFetcher<SearchResult>) {
        self.fetcher = fetcher
    }
    
    func fetchByHashTag(_ string: String) {
        state.value = .fetching
        fetcher.request(.search(string)) { [weak self] result in
            switch result {
            case .success(let searchResult):
                self?.tweets.value = searchResult.tweets.map { TweetViewModel(tweet: $0) }
                self?.state.value = .success
            case .failure(_):
                self?.state.value = .error
                break
            }
        }
    }
}

extension SearchViewModel: FeedViewModelInterface {
    
    subscript(index: Int) -> TweetViewModel {
        get {
            return tweets.value![index]
        }
    }
    
    var tweetsCount: Int {
        return tweets.value!.count
    }
    
}
