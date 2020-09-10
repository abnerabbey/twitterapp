//
//  ViewFactory.swift
//  TwitterApp
//
//  Created by Abner Castro on 26/08/20.
//  Copyright © 2020 Abner Castro. All rights reserved.
//

import Foundation
import UIKit

func create<T: NSObject>(_ setup: (T) -> ()) -> T {
    let obj = T()
    setup(obj)
    return obj
}
