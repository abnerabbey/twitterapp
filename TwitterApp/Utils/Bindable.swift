//
//  Bindable.swift
//  TwitterApp
//
//  Created by Abner Castro on 14/08/20.
//  Copyright © 2020 Abner Castro. All rights reserved.
//

import Foundation

protocol Bindable {
    associatedtype State
    typealias Listener = (State) -> ()
    
    var value: State? { get set }
    var listener: Listener? { get set }
    mutating func bind(_ listener: @escaping Listener)
}
