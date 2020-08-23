//
//  ViewControllerFactories.swift
//  TwitterApp
//
//  Created by Abner Castro on 14/08/20.
//  Copyright © 2020 Abner Castro. All rights reserved.
//

import Foundation

protocol TabBarControllerFactory {
    func makeTabBarRootViewController() -> RootTabBarController
}

protocol FeedVCFactory {
    func makeFeedViewController() -> FeedViewController
}

protocol SearchVCFactory {
    func makeSearchViewController() -> SearchViewController
}

protocol ComposeVCFactory {
    func makeComposeViewController() -> ComposeViewController
}
