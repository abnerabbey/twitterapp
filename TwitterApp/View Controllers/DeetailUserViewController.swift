//
//  DeetailUserViewController.swift
//  TwitterApp
//
//  Created by Abner Castro on 26/08/20.
//  Copyright © 2020 Abner Castro. All rights reserved.
//

import UIKit

final class DeetailUserViewController: UIViewController {
    
    var viewModel: DetailUserViewModel?
    var rootView: UserRootView?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModelBinds()
        viewModel?.requestUser()
    }
    
    private func setupUI() {
        let rightButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(dismissView))
        navigationItem.rightBarButtonItem = rightButton
    }
    
    @objc func dismissView() {
        dismiss(animated: true, completion: nil)
    }
    
}

// MARK: - ViewModel Binds
extension DeetailUserViewController: FetchableImage {
    
    private func viewModelBinds() {
        viewModel?.user.bind { [weak self] user in
            self?.fetchImage(from: user.coverImageURL, completion: { data in
                DispatchQueue.main.async {
                    guard let data = data else { return }
                    let image = UIImage(data: data)
                    let imageView = UIImageView(image: image)
                    self?.navigationItem.titleView = imageView
                }
            })
        }
    }
    
}
