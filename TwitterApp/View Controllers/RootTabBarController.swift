//
//  RootTabBarController.swift
//  TwitterApp
//
//  Created by Abner Castro on 14/08/20.
//  Copyright © 2020 Abner Castro. All rights reserved.
//

import UIKit

final class RootTabBarController: UITabBarController {
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    let feedViewController: FeedViewController
    let searchViewController: SearchViewController
    
    init(feedVCFactory: FeedVCFactory, searchVCFactory: SearchVCFactory) {
        let factory = ObjectFactories()
        
        feedViewController = feedVCFactory.makeFeedViewController()
        let feedCoordinator = factory.makeNavCoordinator(with: feedViewController)
        feedViewController.navCoordinator = feedCoordinator as? NavCoordinator
        
        searchViewController = searchVCFactory.makeSearchViewController()
        let searchCoordinator = factory.makeNavCoordinator(with: searchViewController)
        searchViewController.navCoordinator = searchCoordinator as? NavCoordinator
        
        super.init(nibName: nil, bundle: nil)
        
        viewControllers = [feedCoordinator.rootViewController, searchCoordinator.rootViewController]
        
        selectedIndex = 0
    }
    
    
    
    
}

