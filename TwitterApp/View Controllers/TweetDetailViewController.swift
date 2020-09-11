//
//  TweetDetailViewController.swift
//  TwitterApp
//
//  Created by Abner Castro on 25/08/20.
//  Copyright © 2020 Abner Castro. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class TweetDetailViewController: UIViewController {
    
    private let scrollView: UIScrollView = {
        return UIScrollView()
    }()
    
    private let contentView: UIView = {
        return UIView()
    }()
    
    weak var navCoordinator: NavCoordinator?
    var viewModel: TweetViewModel?
    var rootView: TweetDetail?
    
    let bag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barTintColor = viewModel?.user.backgroundColor
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.barTintColor = .redMain
    }
    
    override func loadView() {
        guard let viewModel = viewModel else { return }
        rootView = TweetDetail(viewModel: viewModel)
        view = rootView
    }
    
    
    private func setupUI() {
        title = "Tweet"
    }
}

// MARK: - View - Controller Bindings
extension TweetDetailViewController {
    
    private func bindView() {
        bindShareButtonState()
    }
    
    private func bindShareButtonState() {
        rootView?.shareTapped.subscribe(onNext: { [weak self] text in
            guard let self = self else { return }
            self.navCoordinator?.presentShareViewController(withText: text)
        })
        .disposed(by: bag)
    }
    
}
