//
//  UserViewModel.swift
//  TwitterApp
//
//  Created by Abner Castro on 14/08/20.
//  Copyright © 2020 Abner Castro. All rights reserved.
//

import Foundation
import UIKit

protocol UserViewModelable {
    var name: String { get }
    var nickname: String { get }
    var description: String { get }
    var location: String { get }
    var followers: String { get }
    var creation: String { get }
    var backgroundColor: UIColor { get }
    var profileImageURL: String { get }
    var coverImageURL: String { get }
}

struct UserViewModel: UserViewModelable {
    var name: String {
        return user.name
    }
    
    var nickname: String {
        return user.nickname
    }
    
    var description: String {
        return user.description
    }
    
    var location: String {
        return user.location
    }
    
    var followers: String {
        return String(user.followers)
    }
    
    var creation: String {
        return user.creation
    }
    
    var backgroundColor: UIColor {
        return UIColor(hexString: user.backgroundColor)
    }
    
    var profileImageURL: String {
        return user.profileImageURL
    }
    
    var coverImageURL: String {
        return user.coverImageURL
    }
    
    
    private let user: User
    
    init(user: User) {
        self.user = user
    }
}
