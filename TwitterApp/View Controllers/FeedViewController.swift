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

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        view = FeedRootView()
    }
}
