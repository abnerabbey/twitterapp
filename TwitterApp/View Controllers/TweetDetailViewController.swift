//
//  TweetDetailViewController.swift
//  TwitterApp
//
//  Created by Abner Castro on 25/08/20.
//  Copyright © 2020 Abner Castro. All rights reserved.
//

import UIKit

final class TweetDetailViewController: UIViewController {
    
    weak var navCoordinator: NavCoordinator?
    var viewModel: TweetViewModel?
    var rootView: TweetDetail?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindView()
    }
    
    override func loadView() {
        guard let viewModel = viewModel else { return }
        rootView = TweetDetail(viewModel: viewModel)
        view = rootView
    }
    
    
    private func setupUI() {
        title = "Tweet"
    }
}

// MARK: - View - Controller Bindings
extension TweetDetailViewController {
    
    private func bindView() {
        bindShareButtonState()
    }
    
    private func bindShareButtonState() {
        rootView?.shareTapped.bind({ [weak self] text in
            self?.navCoordinator?.presentShareViewController(withText: text)
        })
    }
    
}
