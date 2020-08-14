//
//  RootTabBarController.swift
//  TwitterApp
//
//  Created by Abner Castro on 14/08/20.
//  Copyright © 2020 Abner Castro. All rights reserved.
//

import UIKit

class RootTabBarController: UITabBarController {
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    let feedViewController: FeedViewController
    let searchViewController: SearchViewController
    
    init(feedVCFactory: FeedVCFactory, searchVCFactory: SearchVCFactory) {
        feedViewController = feedVCFactory.makeFeedViewController()
        searchViewController = searchVCFactory.makeSearchViewController()
        super.init(nibName: nil, bundle: nil)
        
        viewControllers = [UINavigationController(rootViewController: feedViewController), UINavigationController(rootViewController: searchViewController)]
        selectedIndex = 0
    }
    
    
}
