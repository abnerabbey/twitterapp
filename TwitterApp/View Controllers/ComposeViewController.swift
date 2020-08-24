//
//  ComposeViewController.swift
//  TwitterApp
//
//  Created by Abner Castro on 23/08/20.
//  Copyright © 2020 Abner Castro. All rights reserved.
//

import UIKit

final class ComposeViewController: UIViewController {
    
    var rootView: ComposeRootView?
    var viewModel: ComposeViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModels()
    }
    
    override func loadView() {
        super.loadView()
        guard let viewModel = viewModel else { return }
        rootView = ComposeRootView(viewModel: viewModel)
        view = rootView
    }
    
    @objc private func dismissAction() {
        dismiss(animated: true, completion: nil)
    }
}

extension ComposeViewController {
    
    private func setupUI() {
        title = "Compose your tweet"
        let leftButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(dismissAction))
        navigationItem.leftBarButtonItem = leftButton
    }
    
    private func bindViewModels() {
        viewModel?.imageSelected.bind({ [weak self] image in
            let icon = image.scaled(.init(width: 30, height: 30)).withRenderingMode(.alwaysOriginal)
            self?.navigationItem.rightBarButtonItem = UIBarButtonItem(image: icon, style: .done, target: nil, action: nil)
        })
    }
    
}
