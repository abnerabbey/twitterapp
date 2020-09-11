//
//  +PHPhotosLibrary.swift
//  TwitterApp
//
//  Created by Abner Castro on 24/08/20.
//  Copyright © 2020 Abner Castro. All rights reserved.
//

import Foundation
import Photos
import RxCocoa
import RxSwift

extension PHPhotoLibrary {
    
    static var authorized: PublishSubject<Bool> {
        let state = PublishSubject<Bool>()
        DispatchQueue.main.async {
            if authorizationStatus() == .authorized {
                state.onNext(true)
            } else {
                requestAuthorization { status in
                    state.onNext(status == .authorized)
                }
            }
        }
        return state
    }
    
}
