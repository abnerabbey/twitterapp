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
        case fav
        case ret
        case comment
        case share
        case profile
    }
    
    convenience init!(assetIdenfier identifier: AssetIdentifier) {
        self.init(named: identifier.rawValue)!
    }
    
    func scaled(_ newSize: CGSize) -> UIImage {
      guard size != newSize else {
        return self
      }

      let ratio = max(newSize.width / size.width, newSize.height / size.height)
      let width = size.width * ratio
      let height = size.height * ratio

      let scaledRect = CGRect(
        x: (newSize.width - width) / 2.0,
        y: (newSize.height - height) / 2.0,
        width: width, height: height)

      UIGraphicsBeginImageContextWithOptions(scaledRect.size, false, 0.0);
      defer { UIGraphicsEndImageContext() }

      draw(in: scaledRect)

      return UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
    }
}
