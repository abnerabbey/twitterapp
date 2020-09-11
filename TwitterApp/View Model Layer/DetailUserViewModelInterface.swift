//
//  DetailUserViewModelInterface.swift
//  TwitterApp
//
//  Created by Abner Castro on 26/08/20.
//  Copyright © 2020 Abner Castro. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

protocol DetailUserViewModelInterface {
    var user: PublishSubject<UserViewModel> { get set }
    var state: PublishSubject<State> { get set }
    func requestUser()
}
