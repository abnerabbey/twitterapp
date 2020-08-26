//
//  +UIViewController.swift
//  TwitterApp
//
//  Created by Abner Castro on 14/08/20.
//  Copyright © 2020 Abner Castro. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    enum Identifier: String {
        case feed = "feedVC"
        case search = "searchVC"
        case composeVC = "composeVC"
        case tweetDetail = "detailsVC"
        case detailUser = "DetailUserVC"
    }
}
