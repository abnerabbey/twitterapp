//
//  ObjectFactories.swift
//  TwitterApp
//
//  Created by Abner Castro on 14/08/20.
//  Copyright © 2020 Abner Castro. All rights reserved.
//

import Foundation
import UIKit

class ObjectFactories: Storyboarded {
    
}

// MARK: - View Controllers Factories
extension ObjectFactories: FeedVCFactory, SearchVCFactory, ComposeVCFactory, TweetVCFactory, ProfileVCFactory { }

extension ObjectFactories {
    
    func makeFeedViewController() -> FeedViewController {
        guard let feedViewController = instantiateViewController(withIdentifier: .feed) as? FeedViewController else { fatalError("Invalid Feed View Controller Creation") }
        feedViewController.viewModel = FeedViewModel(fetcher: AnyFetcher(fetcher: FetcherImplementation()))
        feedViewController.tabBarItem = .init(title: "Feed", image: .init(assetIdenfier: .feed), tag: 0)
        return feedViewController
    }
    
    func makeSearchViewController() -> SearchViewController {
        guard let searchViewController = instantiateViewController(withIdentifier: .search) as? SearchViewController else { fatalError("Invalid Search View Controller Creation") }
        searchViewController.viewModel = SearchViewModel(fetcher: AnyFetcher(fetcher: FetcherImplementation()))
        searchViewController.tabBarItem = .init(title: "Search", image: .init(assetIdenfier: .search), tag: 1)
        return searchViewController
    }
    
    func makeComposeViewController() -> ComposeViewController {
        guard let composeViewController = instantiateViewController(withIdentifier: .composeVC, withStoryboardName: .compose) as? ComposeViewController else { fatalError("Invalid Compose View Controller Creation") }
        composeViewController.viewModel = ComposeViewModel()
        return composeViewController
    }
    
    func makeTweetViewController() -> TweetDetailViewController {
        guard let tweetViewController = instantiateViewController(withIdentifier: .tweetDetail, withStoryboardName: .detail) as? TweetDetailViewController else { fatalError("Invalid Tweet Detail View Controller") }
        
        return tweetViewController
    }
    
    func makeProfileViewController() -> DeetailUserViewController {
        guard let profileViewController = instantiateViewController(withIdentifier: .detailUser, withStoryboardName: .detail) as? DeetailUserViewController else { fatalError("Invalid Tweet Detail View Controller") }
        
        return profileViewController
    }
    
}

// MARK: - Coordinators Factories
extension ObjectFactories: NavCoordinatorFactory { }

extension ObjectFactories {
    
    func makeNavCoordinator(with vc: UIViewController) -> Coordinator {
        return NavCoordinator(presenter: UINavigationController(rootViewController: vc))
    }
    
}
