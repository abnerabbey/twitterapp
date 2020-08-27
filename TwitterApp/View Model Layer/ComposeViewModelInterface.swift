//
//  ComposeViewModelInterface.swift
//  TwitterApp
//
//  Created by Abner Castro on 23/08/20.
//  Copyright © 2020 Abner Castro. All rights reserved.
//

import Foundation
import Photos
import UIKit



protocol ComposeViewModelInterface {
    
    var totalChars: Int { get }
    var photosGrant: Binder<Bool> { get set }
    var status: String { get set }
    var state: Binder<State> { get set }
    
    func charactersRemaining(text: String, range: NSRange, inputText: String) -> Int
    func requestPhotosAccess()
    func publishTweet()
}

protocol ComposeViewModelPhotos {
    
    var count: Int { get }
    var imageSelected: Binder<UIImage> { get set }
    subscript(index: Int) -> PHAsset { get }
    func requestImage(for index: Int, size: CGSize, completion: @escaping (UIImage?, [AnyHashable: Any]?) -> ())
}

typealias CVMInterface = ComposeViewModelInterface & ComposeViewModelPhotos
