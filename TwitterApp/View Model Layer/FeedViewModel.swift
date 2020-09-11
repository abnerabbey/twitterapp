//
//  FeedViewModel.swift
//  TwitterApp
//
//  Created by Abner Castro on 14/08/20.
//  Copyright © 2020 Abner Castro. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class FeedViewModel {
    
    let fetcher: AnyFetcher<[Tweet]>
    var state = PublishSubject<State>()
    
    private var tweets = BehaviorSubject<[TweetViewModel]>(value: [])
    
    
    init(fetcher: AnyFetcher<[Tweet]>) {
        self.fetcher = fetcher
    }
    
    func fetchTimeLine() {
        state.onNext(.fetching)
        fetcher.request(.timeline) { [weak self] result in
            switch result {
            case .success(let tweets):
                self?.tweets.onNext(tweets.map { TweetViewModel(tweet: $0) })
                self?.state.onNext(.success)
            case .failure(_):
                self?.state.onNext(.error)
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
            do {
                let elements = try tweets.value()
                return elements[index]
            } catch {
                fatalError("Error while trying to get the view model")
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
