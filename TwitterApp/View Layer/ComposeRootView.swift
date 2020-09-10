//
//  ComposeRootView.swift
//  TwitterApp
//
//  Created by Abner Castro on 23/08/20.
//  Copyright © 2020 Abner Castro. All rights reserved.
//

import UIKit
import Photos

class ComposeRootView: UIView {
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    var viewModel: CVMInterface
    private var dataSource: CollectionViewDataSource<PhotosCell>
    
    let textView: UITextView = create {
        $0.accessibilityIdentifier = "textView"
    }
    
    let publishButton: UIButton = create {
        $0.setTitle("Publish", for: .normal)
        $0.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 14)
        $0.setTitleColor(.white, for: .normal)
        $0.setTitleColor(.systemGray, for: .disabled)
        $0.backgroundColor = .redMain
        $0.layer.cornerRadius = 5
        $0.anchor(top: nil, leading: nil, trailing: nil, bottom: nil, size: .init(width: 60, height: 0))
    }
    
    let counterLabel: UILabel = create {
        $0.accessibilityIdentifier = "counterLabel"
        $0.text = "Characters remaining: "
        $0.font = UIFont(name: "Helvetica", size: 11)
        $0.textColor = .systemGray
        $0.anchor(top: nil, leading: nil, trailing: nil, bottom: nil, size: .init(width: 0, height: 30))
    }
    
    lazy var horizontalStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [counterLabel, publishButton])
        stack.axis = .horizontal
        //stack.spacing = 4
        return stack
    }()
    
    let collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: .init())
        collection.backgroundColor = .white
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = .init(width: 60, height: 60)
        collection.setCollectionViewLayout(layout, animated: false)
        return collection
    }()
    
    init(frame: CGRect = .zero, viewModel: CVMInterface) {
        self.viewModel = viewModel
        self.dataSource = CollectionViewDataSource(cellIdentifier: "photosCell", items: viewModel.count, configureCell: { (cell, indexPath) in
            viewModel.requestImage(for: indexPath.row, size: cell.newImageView.frame.size) { (image, _) in
                cell.newImageView.image = image
            }
        })
        super.init(frame: frame)
        backgroundColor = .white
        buildHierarchy()
        buildConstraints()
        setupUI()
        viewModelBinds()
        viewModel.requestPhotosAccess()
    }
    
    @objc private func hideKeyboard() {
        endEditing(true)
    }
    
}

// MARK: - CollectionView Delegates
extension ComposeRootView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? PhotosCell else { return }
        cell.flash()
        viewModel.requestImage(for: indexPath.item, size: frame.size) { [weak self] (image, info) in
            guard let image = image, let info = info else { return }
            if let isThumbnail = info[PHImageResultIsDegradedKey as NSString] as? Bool, !isThumbnail {
                self?.viewModel.imageSelected.value = image
            }
        }
    }
}

// MARK: - TextView Delegate
extension ComposeRootView: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let charsRemaining = viewModel.charactersRemaining(text: textView.text, range: range, inputText: text)
        guard charsRemaining <= 140 else { return false }
        viewModel.status = textView.text + text
        counterLabel.text = "Characters remaining: \(140 - charsRemaining)"
        return true
    }
}

// MARK: - View Hierarchy and Auto Layout
extension ComposeRootView {
    
    private func buildHierarchy() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        tapGesture.cancelsTouchesInView = false
        addGestureRecognizer(tapGesture)
        addSubview(textView)
        addSubview(horizontalStack)
        addSubview(collectionView)
    }
    
    private func buildConstraints() {
        textView.anchor(top: topAnchor, leading: leadingAnchor, trailing: trailingAnchor, bottom: nil, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 150))
        horizontalStack.anchor(top: textView.bottomAnchor, leading: textView.leadingAnchor, trailing: textView.trailingAnchor, bottom: nil, padding: .init(top: 16, left: 8, bottom: 0, right: 8))
        collectionView.anchor(top: horizontalStack.bottomAnchor, leading: textView.leadingAnchor, trailing: textView.trailingAnchor, bottom: bottomAnchor, padding: .init(top: 32, left: 0, bottom: 0, right: 0))
    }
    
    private func setupUI() {
        textView.delegate = self
        textView.becomeFirstResponder()
        counterLabel.text = "Characters remaining: \(viewModel.totalChars)"
        collectionView.register(PhotosCell.self, forCellWithReuseIdentifier: "photosCell")
        collectionView.dataSource = dataSource
        collectionView.delegate = self
        publishButton.addTarget(self, action: #selector(publishTweet), for: .touchUpInside)
    }
    
    @objc private func publishTweet() {
        viewModel.publishTweet()
    }
    
}

// MARK: - View Model bindings
extension ComposeRootView {
    
    private func viewModelBinds() {
        bindPhotoAccess()
    }
    
    private func bindPhotoAccess() {
        viewModel.photosGrant.bind { [weak self] granted in
            if granted {
                self?.collectionView.reloadData()
            }
        }
    }
}
