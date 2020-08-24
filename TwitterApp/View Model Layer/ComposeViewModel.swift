//
//  ComposeViewModel.swift
//  TwitterApp
//
//  Created by Abner Castro on 23/08/20.
//  Copyright © 2020 Abner Castro. All rights reserved.
//

import Foundation
import UIKit
import Photos

final class ComposeViewModel: ComposeViewModelInterface {
    
    var totalChars: Int {
        return 140
    }
    
    var photosGrant = Binder<Bool>()
    var imageSelected = Binder<UIImage>()
    private lazy var photos = ComposeViewModel.loadPhotos()
    private lazy var imageManager = PHCachingImageManager()
    
    func charactersRemaining(text: String, range: NSRange, inputText: String) -> Int {
        let newText = (text as NSString).replacingCharacters(in: range, with: inputText)
        let numberOfChars = newText.count
        return numberOfChars
    }
}

// MARK: - Photos Interface
extension ComposeViewModel: ComposeViewModelPhotos {
    var count: Int {
        return photos.count
    }
    
    subscript(index: Int) -> PHAsset {
        get {
            return photos.object(at: index)
        }
    }
    
    func requestImage(for index: Int, size: CGSize, completion: @escaping (UIImage?, [AnyHashable : Any]?) -> ()) {
        imageManager.requestImage(for: photos.object(at: index), targetSize: size, contentMode: .aspectFill, options: nil, resultHandler: completion)
    }
}


// MARK: - Photos Stuff
extension ComposeViewModel {
    
    static func loadPhotos() -> PHFetchResult<PHAsset> {
        let allPhotos = PHFetchOptions()
        allPhotos.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        return PHAsset.fetchAssets(with: allPhotos)
    }
 
    func requestPhotosAccess() {
        if PHPhotoLibrary.authorizationStatus() == .authorized {
            photosGrant.value = true
            photos = ComposeViewModel.loadPhotos()
        } else {
            PHPhotoLibrary.requestAuthorization { [weak self] newStatus in
                DispatchQueue.main.async {
                    self?.photosGrant.value = newStatus == .authorized
                    guard let value = self?.photosGrant.value, value == true else { return }
                    self?.photos = ComposeViewModel.loadPhotos()
                }
            }
        }
    }
}
