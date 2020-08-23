//
//  ComposeViewController.swift
//  TwitterApp
//
//  Created by Abner Castro on 23/08/20.
//  Copyright © 2020 Abner Castro. All rights reserved.
//

import UIKit

final class ComposeViewController: UIViewController {
    
    var rootView: ComposeRootView?

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        super.loadView()
        rootView = ComposeRootView()
        view = rootView
    }

}
