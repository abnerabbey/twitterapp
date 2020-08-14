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
