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
extension ObjectFactories: FeedVCFactory, SearchVCFactory { }

extension ObjectFactories {
    
    func makeFeedViewController() -> FeedViewController {
        guard let feedViewController = instantiateViewController(withIdentifier: .feed) as? FeedViewController else { fatalError("Invalid Feed View Controller Creation") }
        
        feedViewController.tabBarItem = .init(title: "Feed", image: .init(assetIdenfier: .feed), tag: 0)
        return feedViewController
    }
    
    func makeSearchViewController() -> SearchViewController {
        guard let searchViewController = instantiateViewController(withIdentifier: .search) as? SearchViewController else { fatalError("Invalid Search View Controller Creation") }
        
        searchViewController.tabBarItem = .init(title: "Search", image: .init(assetIdenfier: .search), tag: 1)
        return searchViewController
    }
    
    
}
