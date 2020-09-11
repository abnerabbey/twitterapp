//
//  FeedRootView.swift
//  TwitterApp
//
//  Created by Abner Castro on 14/08/20.
//  Copyright © 2020 Abner Castro. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol FeedRootViewDelegate: class {
    func didSelect(_ tweet: TweetViewModel)
    func didTapShareTweet(withText text: String)
    func didFail(withError error: String)
}

final class FeedRootView: UIView {
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private let tableView: UITableView = create {
        $0.alpha = 0
    }
    
    var viewModel: FeedViewModelInterface
    weak var delegate: FeedRootViewDelegate?
    
    let bag = DisposeBag()
    
    init(frame: CGRect = .zero, viewModel: FeedViewModelInterface) {
        self.viewModel = viewModel
        super.init(frame: frame)
        backgroundColor = .white
        constructHierarchy()
        activateConstraints()
        setupUI()
        bindViewModel()
        viewModel.fetchTimeLine()
    }
}

// MARK: - Table View Delegates
extension FeedRootView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tweetsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell") as? TweetCell else { fatalError("Invalid Feed Cell") }
        let vm = viewModel[indexPath.row]
        cell.configure(with: vm)
        cell.shareTapped.subscribe(onNext: { [weak self] text in self?.delegate?.didTapShareTweet(withText: text)})
            .disposed(by: bag)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelect(viewModel[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

// MARK: - SearchController Delegates
extension FeedRootView: UISearchBarDelegate, UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text, !text.isEmpty else { return }
        viewModel.fetchByHashTag(text)
    }
}

// MARK: - View Hierarchy
extension FeedRootView {
    
    private func constructHierarchy() {
        addSubview(tableView)
    }
    
    private func setupUI() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TweetCell.self, forCellReuseIdentifier: "feedCell")
    }
    
}

// MARK: - View Auto Layout
extension FeedRootView {
    
    private func activateConstraints() {
        activateTableViewContraints()
    }
    
    private func activateTableViewContraints() {
        tableView.anchor(top: topAnchor, leading: leadingAnchor, trailing: trailingAnchor, bottom: bottomAnchor)
    }
    
}

// MARK: - View Model Bindings
extension FeedRootView {
    
    private func bindViewModel() {
        viewModel.state.subscribe(onNext: { [weak self] state in
            guard let self = self else { return }
            switch state {
            case .success:
                self.tableView.reloadData()
                UIView.animate(withDuration: 0.5) {
                    self.tableView.alpha = 1
                }
                self.hideHud()
            case .error:
                self.hideHud()
                self.delegate?.didFail(withError: "There was an error. Try it later")
            case .fetching:
                if self.viewModel.flow == .feed {
                    self.showHud()
                }
            }
            })
            .disposed(by: bag)
    }
}
