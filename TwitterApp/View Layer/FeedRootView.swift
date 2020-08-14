//
//  FeedRootView.swift
//  TwitterApp
//
//  Created by Abner Castro on 14/08/20.
//  Copyright © 2020 Abner Castro. All rights reserved.
//

import UIKit

final class FeedRootView: UIView {
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    private let tableView: UITableView = {
       let table = UITableView()
        return table
    }()
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        constructHierarchy()
        activateConstraints()
    }
    
}

// MARK: - View Hierarchy
extension FeedRootView {
    
    private func constructHierarchy() {
        addSubview(tableView)
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
