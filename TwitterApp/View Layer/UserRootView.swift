//
//  UserRootView.swift
//  TwitterApp
//
//  Created by Abner Castro on 26/08/20.
//  Copyright © 2020 Abner Castro. All rights reserved.
//

import UIKit

class UserRootView: UIView {
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    var imageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    
    var viewModel: DetailUserViewModel
    
    init(frame: CGRect = .zero, viewModel: DetailUserViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        backgroundColor = .white
        buildHierarchy()
        activateConstraints()
        viewModelBinds()
        viewModel.requestUser()
    }
}

// MARK: - View Hierarchy and Auto Layout
extension UserRootView {
    
    private func buildHierarchy() {
        addSubview(imageView)
    }
    
    private func activateConstraints() {
        imageView.anchor(top: topAnchor, leading: leadingAnchor, trailing: trailingAnchor, bottom: bottomAnchor, padding: .init(top: 0, left: 0, bottom: 350, right: 0))
    }
    
}

// MARK: - ViewModelBinds
extension UserRootView: FetchableImage {
    
    private func viewModelBinds() {
        userViewModelBind()
    }
    
    private func userViewModelBind() {
        viewModel.user.bind { [weak self] user in
            self?.fetchImage(from: user.coverImageURL) { data in
                DispatchQueue.main.async {
                    guard let data = data else { return }
                    self?.imageView.image = UIImage(data: data)
                }
            }
        }
    }
}
