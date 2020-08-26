//
//  NavCoordinator.swift
//  TwitterApp
//
//  Created by Abner Castro on 14/08/20.
//  Copyright © 2020 Abner Castro. All rights reserved.
//

import Foundation
import UIKit

class NavCoordinator {
    
    private let presenter: UINavigationController
    
    init(presenter: UINavigationController) {
        self.presenter = presenter
    }
    
}

extension NavCoordinator: Coordinator {
    var rootViewController: UIViewController {
        return presenter
    }
    
    func start() {}
    
}

// MARK: - Navigation Methods
extension NavCoordinator {
    
    func goToComposeTweetVC() {
        let factory = ObjectFactories()
        let composeVC = factory.makeComposeViewController()
        let nv = UINavigationController(rootViewController: composeVC)
        presenter.present(nv, animated: true, completion: nil)
    }
    
    func goToTweetDetailVC(withTweet tweet: TweetViewModel) {
        let factory = ObjectFactories()
        let tweetVC = factory.makeTweetViewController()
        tweetVC.viewModel = tweet
        tweetVC.navCoordinator = self
        presenter.pushViewController(tweetVC, animated: true)
    }
    
    func presentShareViewController(withText text: String) {
        let composeVC = UIActivityViewController(activityItems: [text], applicationActivities: nil)
        presenter.present(composeVC, animated: true, completion: nil)
    }
    
    func goToProfileVC() {
        let factory = ObjectFactories()
        let profileVC = factory.makeProfileViewController()
        let nv = UINavigationController(rootViewController: profileVC)
        presenter.present(nv, animated: true, completion: nil)
    }
}
