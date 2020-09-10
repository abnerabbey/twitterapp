//
//  TweetDetail.swift
//  TwitterApp
//
//  Created by Abner Castro on 25/08/20.
//  Copyright © 2020 Abner Castro. All rights reserved.
//

import UIKit

final class TweetDetail: UIView, FetchableImage {
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            imageView.layer.cornerRadius = imageView.frame.height / 2
        }
    }
    @IBOutlet weak var nameLabel: UILabel! {
        didSet {
            nameLabel.adjustsFontSizeToFitWidth = true
        }
    }
    @IBOutlet weak var usernameLabel: UILabel!
    
    let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        return scroll
    }()
    
    let contentView: UIView = create {
        $0.backgroundColor = .white
    }
    
    let contentLabel: UILabel = create {
        $0.font = UIFont(name: "Helvetica-light", size: 17)
        $0.numberOfLines = 0
        $0.textColor = .black
    }
    
    let dateLabel: UILabel = create {
        $0.font = UIFont(name: "Helvetica", size: 11)
        $0.numberOfLines = 1
        $0.textColor = .systemGray
    }
    
    let separationView: UIView = create {
        $0.backgroundColor = .systemGray5
    }
    
    let favsLabel: UILabel = create {
        $0.font = UIFont(name: "Helvetica", size: 12)
        $0.numberOfLines = 1
        $0.textColor = .systemGray
        $0.text = " Me gusta"
    }
    
    let retsLabel: UILabel = create {
        $0.font = UIFont(name: "Helvetica", size: 12)
        $0.numberOfLines = 1
        $0.textColor = .systemGray
        $0.text = " Retweets"
    }
    
    private lazy var countStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [favsLabel, retsLabel])
        stack.axis = .horizontal
        stack.spacing = 15
        return stack
    }()
    
    let separationView2: UIView = create {
        $0.backgroundColor = .systemGray5
    }
    
    let commentButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(.init(assetIdenfier: .comment), for: .normal)
        button.tintColor = .redMain
        return button
    }()
    
    let retButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(.init(assetIdenfier: .ret), for: .normal)
        button.tintColor = .redMain
        return button
    }()
    
    let favButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(.init(assetIdenfier: .fav), for: .normal)
        button.tintColor = .redMain
        return button
    }()
    
    let shareButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(.init(assetIdenfier: .share), for: .normal)
        button.tintColor = .redMain
        return button
    }()
    
    private lazy var buttonsStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [commentButton, retButton, favButton, shareButton])
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        return stack
    }()
    
    var shareTapped = Binder<String>()
    
    var viewModel: TweetViewModel
    
    init(frame: CGRect = .zero, viewModel: TweetViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        backgroundColor = .white
        buildHierarchy()
        activateConstraints()
        setupUI()
    }
    
    private func setupUI() {
        nameLabel.text = viewModel.user.name
        usernameLabel.text = viewModel.user.nickname
        fetchImage(from: viewModel.user.profileImageURL) { [weak self] data in
            DispatchQueue.main.async {
                guard let data = data else { return }
                self?.imageView.image = UIImage(data: data)
            }
        }
        contentLabel.text = viewModel.text
        dateLabel.text = viewModel.creation
        favsLabel.text = "\(viewModel.favs)" + favsLabel.text!
        retsLabel.text = "\(viewModel.retweets)" + retsLabel.text!
        shareButton.addTarget(self, action: #selector(shareTweet), for: .touchUpInside)
    }
    
    @objc private func shareTweet() {
        shareTapped.value = viewModel.text
    }
}

// MARK: - View Hierarchy and Constraints
extension TweetDetail {
    
    private func buildHierarchy() {
        scrollView.addSubview(contentView)
        let xibView = loadView()
        contentView.addSubview(xibView)
        contentView.addSubview(contentLabel)
        contentView.addSubview(dateLabel)
        contentView.addSubview(separationView)
        contentView.addSubview(countStack)
        contentView.addSubview(separationView2)
        contentView.addSubview(buttonsStack)
        addSubview(scrollView)
    }
    
    private func activateConstraints() {
        scrollView.anchor(top: topAnchor, leading: leadingAnchor, trailing: trailingAnchor, bottom: bottomAnchor)
        contentView.dimensionAnchors(height: scrollView.heightAnchor, width: scrollView.widthAnchor)
        contentView.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, trailing: scrollView.trailingAnchor, bottom: scrollView.bottomAnchor)
        contentLabel.anchor(top: imageView.bottomAnchor, leading: imageView.leadingAnchor, trailing: layoutMarginsGuide.trailingAnchor, bottom: nil, padding: .init(top: 32, left: 0, bottom: 0, right: 0))
        dateLabel.anchor(top: contentLabel.bottomAnchor, leading: contentLabel.leadingAnchor, trailing: contentLabel.trailingAnchor, bottom: nil, padding: .init(top: 20, left: 0, bottom: 0, right: 0))
        separationView.anchor(top: dateLabel.bottomAnchor, leading: dateLabel.leadingAnchor, trailing: dateLabel.trailingAnchor, bottom: nil, padding: .init(top: 10, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 1))
        countStack.anchor(top: separationView.bottomAnchor, leading: separationView.leadingAnchor, trailing: separationView.trailingAnchor, bottom: nil, padding: .init(top: 10, left: 0, bottom: 0, right: 0))
        separationView2.anchor(top: countStack.bottomAnchor, leading: countStack.leadingAnchor, trailing: countStack.trailingAnchor, bottom: nil, padding: .init(top: 10, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 1))
        buttonsStack.anchor(top: separationView2.bottomAnchor, leading: separationView2.leadingAnchor, trailing: separationView2.trailingAnchor, bottom: nil, padding: .init(top: 15, left: 0, bottom: 0, right: 0))
    }
    
    private func loadView() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: "TweetDetail", bundle: bundle)
        if let view = nib.instantiate(withOwner: self, options: nil)[0] as? UIView {
            view.frame = bounds
            return view
        }
        fatalError("No valid view to load from nib")
    }
    
}
