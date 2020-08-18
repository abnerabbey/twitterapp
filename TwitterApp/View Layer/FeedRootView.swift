//
//  FeedRootView.swift
//  TwitterApp
//
//  Created by Abner Castro on 14/08/20.
//  Copyright © 2020 Abner Castro. All rights reserved.
//

import UIKit

final class FeedRootView: UIView, FetchableImage {
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private let tableView: UITableView = {
       let table = UITableView()
        return table
    }()
    
    var viewModel: FeedViewModelInterface
    
    init(frame: CGRect = .zero, viewModel: FeedViewModelInterface) {
        self.viewModel = viewModel
        super.init(frame: frame)
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
        fetchImage(from: vm.user.profileImageURL) { data in
            DispatchQueue.main.async {
                guard let data = data else { return }
                cell.newImageView.image = UIImage(data: data)
            }
        }
        return cell
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
        viewModel.state.bind { [unowned self] state in
            switch state {
            case .success:
                self.tableView.reloadData()
            case .error:
                print("there's an error")
            default:
                break
            }
        }
    }
    
    
}
