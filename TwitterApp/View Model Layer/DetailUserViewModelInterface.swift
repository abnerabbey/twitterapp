//
//  DetailUserViewModelInterface.swift
//  TwitterApp
//
//  Created by Abner Castro on 26/08/20.
//  Copyright © 2020 Abner Castro. All rights reserved.
//

import Foundation

protocol DetailUserViewModelInterface {
    var user: Binder<UserViewModel> { get set }
    func requestUser()
}
