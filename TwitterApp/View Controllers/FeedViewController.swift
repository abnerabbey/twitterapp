//
//  FeedViewController.swift
//  TwitterApp
//
//  Created by Abner Castro on 14/08/20.
//  Copyright © 2020 Abner Castro. All rights reserved.
//

import UIKit

final class FeedViewController: UIViewController {
    
    var navCoordinator: Coordinator?
    var viewModel: FeedViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        guard let viewModel = viewModel else { return }
        view = FeedRootView(viewModel: viewModel)
    }
}
