//
//  Storyboarded.swift
//  TwitterApp
//
//  Created by Abner Castro on 14/08/20.
//  Copyright © 2020 Abner Castro. All rights reserved.
//

import Foundation
import UIKit

protocol Storyboarded {
    func instantiateViewController(withIdentifier identifer: UIViewController.Identifier, withStoryboardName name: UIStoryboard.Name?) -> UIViewController
}

extension Storyboarded {
    
    func instantiateViewController(withIdentifier identifer: UIViewController.Identifier, withStoryboardName name: UIStoryboard.Name? = nil) -> UIViewController {
        
        var storyboard: UIStoryboard
        if let name = name {
            storyboard = UIStoryboard(name: name.rawValue, bundle: .main)
        }
        storyboard = UIStoryboard(name: "Main", bundle: .main)
        
        return storyboard.instantiateViewController(withIdentifier: identifer.rawValue)
    }
    
}
