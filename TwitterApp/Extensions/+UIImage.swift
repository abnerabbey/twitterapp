//
//  +UIImage.swift
//  TwitterApp
//
//  Created by Abner Castro on 14/08/20.
//  Copyright © 2020 Abner Castro. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    enum AssetIdentifier: String {
        case feed
        case search
        case gato
    }
    
    convenience init!(assetIdenfier identifier: AssetIdentifier) {
        self.init(named: identifier.rawValue)!
    }
}
