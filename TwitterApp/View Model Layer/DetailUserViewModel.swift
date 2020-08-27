//
//  DetailUserViewModel.swift
//  TwitterApp
//
//  Created by Abner Castro on 26/08/20.
//  Copyright © 2020 Abner Castro. All rights reserved.
//

import Foundation

class DetailUserViewModel {
    
    let fetcher: AnyFetcher<User>
    var user = Binder<UserViewModel>()
    var state = Binder<State>()
    
    init(fetcher: AnyFetcher<User>) {
        self.fetcher = fetcher
    }
}

extension DetailUserViewModel: DetailUserViewModelInterface {
    
    func requestUser() {
        state.value = .fetching
        fetcher.request(.user) { [weak self] result in
            switch result {
            case .success(let user):
                self?.state.value = .success
                self?.user.value = UserViewModel(user: user)
            case .failure(let error):
                self?.state.value = .error
            }
        }
    }
}
