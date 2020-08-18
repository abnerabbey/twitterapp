//
//  SearchViewController.swift
//  TwitterApp
//
//  Created by Abner Castro on 14/08/20.
//  Copyright © 2020 Abner Castro. All rights reserved.
//

import UIKit

final class SearchViewController: UIViewController {
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.searchBar.delegate = rootView
        searchController.searchResultsUpdater = rootView
        return searchController
    }()
    
    var navCoordinator: Coordinator?
    var viewModel: SearchViewModel?
    var rootView: FeedRootView?

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func loadView() {
        guard let viewModel = viewModel else { return }
        rootView = FeedRootView(viewModel: viewModel)
        view = rootView
    }
    
    private func setupUI() {
        title = "Search by #"
        navigationItem.searchController = searchController
    }
    
}
