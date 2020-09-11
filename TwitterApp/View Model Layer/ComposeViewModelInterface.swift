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
import RxSwift
import RxCocoa


protocol ComposeViewModelInterface {
    
    var totalChars: Int { get }
    var photosGrant: BehaviorSubject<Bool> { get set }
    var status: String { get set }
    var state: PublishSubject<State> { get set }
    
    func charactersRemaining(text: String, range: NSRange, inputText: String) -> Int
    func requestPhotosAccess()
    func publishTweet()
}

protocol ComposeViewModelPhotos {
    
    var count: Int { get }
    var imageSelected: PublishSubject<UIImage> { get set }
    subscript(index: Int) -> PHAsset { get }
    func requestImage(for index: Int, size: CGSize, completion: @escaping (UIImage?, [AnyHashable: Any]?) -> ())
}

typealias CVMInterface = ComposeViewModelInterface & ComposeViewModelPhotos
