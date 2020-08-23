//
//  ComposeRootView.swift
//  TwitterApp
//
//  Created by Abner Castro on 23/08/20.
//  Copyright © 2020 Abner Castro. All rights reserved.
//

import UIKit

class ComposeRootView: UIView {
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    let textView: UITextView = {
        let textView = UITextView()
        textView.text = "Compose your tweet here..."
        return textView
    }()
    
    let publishButton: UIButton = {
        let button = UIButton()
        button.setTitle("Publish", for: .normal)
        button.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 14)
        button.setTitleColor(.systemBlue, for: .normal)
        button.setTitleColor(.systemGray, for: .disabled)
        button.layer.cornerRadius = 5
        button.anchor(top: nil, leading: nil, trailing: nil, bottom: nil, size: .init(width: 60, height: 44))
        return button
    }()
    
    let counterLabel: UILabel = {
        let label = UILabel()
        label.text = "Characters remaining: "
        label.font = UIFont(name: "Helvetica", size: 10)
        label.textColor = .systemGray
        label.anchor(top: nil, leading: nil, trailing: nil, bottom: nil, size: .init(width: 0, height: 25))
        return label
    }()
    
    lazy var horizontalStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [counterLabel, publishButton])
        stack.axis = .horizontal
        //stack.spacing = 4
        return stack
    }()
    
    /*let collectionView: UICollectionView = {
        let collection = UICollectionView()
        return collection
    }()*/
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        backgroundColor = .white
        buildHierarchy()
        buildConstraints()
    }
    
    
    
}

// MARK: - View Hierarchy and Auto Layout
extension ComposeRootView {
    
    private func buildHierarchy() {
        addSubview(textView)
        addSubview(horizontalStack)
    }
    
    private func buildConstraints() {
        textView.anchor(top: topAnchor, leading: leadingAnchor, trailing: trailingAnchor, bottom: nil, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 150))
        horizontalStack.anchor(top: textView.bottomAnchor, leading: textView.leadingAnchor, trailing: textView.trailingAnchor, bottom: nil, padding: .init(top: 16, left: 8, bottom: 0, right: 8))
    }
    
}
