//
//  FeedViewController.swift
//  TwitterApp
//
//  Created by Abner Castro on 14/08/20.
//  Copyright © 2020 Abner Castro. All rights reserved.
//

import UIKit

final class FeedViewController: UIViewController {
    
    var navCoordinator: NavCoordinator?
    var viewModel: FeedViewModel?
    var rootView: FeedRootView?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func loadView() {
        guard let viewModel = viewModel else { return }
        rootView = FeedRootView(viewModel: viewModel)
        rootView?.delegate = self
        view = rootView
    }
    
    private func setupUI() {
        title = "WizeTweet"
        let rightButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(composeTweet))
        navigationItem.rightBarButtonItem = rightButton
        let leftButton = UIBarButtonItem(image: .init(assetIdenfier: .profile), style: .plain, target: self, action: #selector(goToProfile))
        navigationItem.leftBarButtonItem = leftButton
    }
    
    @objc private func composeTweet() {
        navCoordinator?.goToComposeTweetVC()
    }
    
    @objc private func goToProfile() {
        navCoordinator?.goToProfileVC()
    }
}

extension FeedViewController: FeedRootViewDelegate {
    
    func didTapShareTweet(withText text: String) {
        navCoordinator?.presentShareViewController(withText: text)
    }
    
    func didSelect(_ tweet: TweetViewModel) {
        navCoordinator?.goToTweetDetailVC(withTweet: tweet)
    }
}
