//
//  DetailUserViewModel.swift
//  TwitterApp
//
//  Created by Abner Castro on 26/08/20.
//  Copyright © 2020 Abner Castro. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class DetailUserViewModel {
    
    let fetcher: AnyFetcher<User>
    var user = PublishSubject<UserViewModel>()
    var state = PublishSubject<State>()
    
    init(fetcher: AnyFetcher<User>) {
        self.fetcher = fetcher
    }
}

extension DetailUserViewModel: DetailUserViewModelInterface {
    
    func requestUser() {
        state.onNext(.fetching)
        fetcher.request(.user) { [weak self] result in
            switch result {
            case .success(let user):
                self?.state.onNext(.success)
                self?.user.onNext(UserViewModel(user: user))
            case .failure(let error):
                self?.state.onNext(.error)
            }
        }
    }
}
