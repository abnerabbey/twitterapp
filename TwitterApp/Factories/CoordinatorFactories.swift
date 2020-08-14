//
//  CoordinatorFactories.swift
//  TwitterApp
//
//  Created by Abner Castro on 14/08/20.
//  Copyright © 2020 Abner Castro. All rights reserved.
//

import Foundation
import UIKit

protocol NavCoordinatorFactory {
    func makeNavCoordinator(with vc: UIViewController) -> Coordinator
}
