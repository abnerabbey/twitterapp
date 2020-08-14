//
//  AppCoordinator.swift
//  TwitterApp
//
//  Created by Abner Castro on 14/08/20.
//  Copyright © 2020 Abner Castro. All rights reserved.
//

import Foundation
import UIKit

class AppCoordinator {
    
    
    private lazy var tabController: RootTabBarController = {
        let factory = ObjectFactories()
        return RootTabBarController(feedVCFactory: factory, searchVCFactory: factory)
    }()
    
    private var window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
}

extension AppCoordinator: Coordinator {
    var rootViewController: UIViewController {
        return tabController
    }
    
    func start() {
        window.rootViewController = tabController
        window.makeKeyAndVisible()
    }
}
