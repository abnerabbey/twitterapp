//
//  Binder.swift
//  TwitterApp
//
//  Created by Abner Castro on 14/08/20.
//  Copyright © 2020 Abner Castro. All rights reserved.
//

import Foundation

struct Binder<T>: Bindable {
    
    typealias State = T
    
    var listener: Listener?
    
    var value: T? {
        didSet {
            if let value = value {
                listener?(value)
            }
        }
    }
    
    init(_ value: State? = nil) {
        self.value = value
    }
    
    mutating func bind(_ listener: @escaping Listener) {
        self.listener = listener
    }
    
    
    
}
