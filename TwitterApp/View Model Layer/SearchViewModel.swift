//
//  SearchViewModel.swift
//  TwitterApp
//
//  Created by Abner Castro on 18/08/20.
//  Copyright © 2020 Abner Castro. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

final class SearchViewModel {
    
    private let fetcher: AnyFetcher<SearchResult>
    private var tweets = BehaviorSubject<[TweetViewModel]>(value: [])
    
    var state: PublishSubject<State> = PublishSubject()
    
    init(fetcher: AnyFetcher<SearchResult>) {
        self.fetcher = fetcher
    }
    
    func fetchByHashTag(_ string: String) {
        state.onNext(.fetching)
        fetcher.request(.search(string)) { [weak self] result in
            switch result {
            case .success(let searchResult):
                self?.tweets.onNext(searchResult.tweets.map { TweetViewModel(tweet: $0) })
                self?.state.onNext(.success)
            case .failure(_):
                self?.state.onNext(.error)
                break
            }
        }
    }
}

extension SearchViewModel: FeedViewModelInterface {
    
    var flow: Flow {
        return .search
    }
    
    subscript(index: Int) -> TweetViewModel {
        get {
            do {
                return try tweets.value()[index]
            } catch {
                fatalError("There was an error while trying to get value at index")
            }
        }
    }
    
    var tweetsCount: Int {
        do {
            return try tweets.value().count
        } catch {
            return 0
        }
    }
    
}
