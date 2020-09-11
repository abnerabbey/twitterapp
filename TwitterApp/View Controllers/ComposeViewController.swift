//
//  ComposeViewController.swift
//  TwitterApp
//
//  Created by Abner Castro on 23/08/20.
//  Copyright © 2020 Abner Castro. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class ComposeViewController: UIViewController {
    
    var rootView: ComposeRootView?
    var viewModel: ComposeViewModel?
    
    let bag = DisposeBag()

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
        viewModel?.imageSelected.subscribe(onNext: { [weak self] image in
            let icon = image.scaled(.init(width: 30, height: 30)).withRenderingMode(.alwaysOriginal)
            self?.navigationItem.rightBarButtonItem = UIBarButtonItem(image: icon, style: .done, target: nil, action: nil)
        })
        .disposed(by: bag)
        
        viewModel?.state.subscribe(onNext: { [weak self] state in
            switch state {
            case .fetching:
                self?.view.showHud()
            case .error, .success:
                self?.view.hideHud()
                self?.showAlert(withMessage: "An error ocurrred")
            }
        })
        .disposed(by: bag)
        
    }
}
