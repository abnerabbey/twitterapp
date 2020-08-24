//
//  +PHPhotosLibrary.swift
//  TwitterApp
//
//  Created by Abner Castro on 24/08/20.
//  Copyright © 2020 Abner Castro. All rights reserved.
//

import Foundation
import Photos

extension PHPhotoLibrary {
    
    static var authorized: Binder<Bool> {
        var state = Binder<Bool>()
        DispatchQueue.main.async {
            if authorizationStatus() == .authorized {
                state.value = true
            } else {
                requestAuthorization { status in
                    state.value = status == .authorized
                }
            }
        }
        return state
    }
    
}
