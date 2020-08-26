//
//  DeetailUserViewController.swift
//  TwitterApp
//
//  Created by Abner Castro on 26/08/20.
//  Copyright © 2020 Abner Castro. All rights reserved.
//

import UIKit

final class DeetailUserViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView! {
        didSet { imageView.layer.cornerRadius = imageView.frame.height / 2 }
    }
    
    let userLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica-bold", size: 20)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .black
        label.alpha = 0
        return label
    }()
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 14)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .systemGray
        label.alpha = 0
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 14)
        label.numberOfLines = 0
        label.textColor = .black
        label.alpha = 0
        return label
    }()
    
    let locationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 11)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .systemGray
        return label
    }()
    
    let creationLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 11)
        label.numberOfLines = 1
        label.adjustsFontSizeToFitWidth = true
        label.textColor = .systemGray
        return label
    }()
    
    private lazy var placesStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [locationLabel, creationLabel])
        stack.axis = .horizontal
        stack.spacing = 15
        stack.alpha = 0
        return stack
    }()
    
    let followersLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 12)
        label.numberOfLines = 1
        label.textColor = .systemGray
        label.text = " Followers"
        return label
    }()
    
    let followingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 12)
        label.numberOfLines = 1
        label.textColor = .systemGray
        label.text = " Following"
        return label
    }()
    
    private lazy var countStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [followersLabel, followingLabel])
        stack.axis = .horizontal
        stack.spacing = 15
        stack.alpha = 0
        return stack
    }()
    
    let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        return scroll
    }()
    
    let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    var viewModel: DetailUserViewModel?
    var rootView: UserRootView?

    override func viewDidLoad() {
        super.viewDidLoad()
        buildHierarchy()
        activateConstraints()
        setupUI()
        viewModelBinds()
        viewModel?.requestUser()
    }
    
    private func setupUI() {
        let rightButton = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(dismissView))
        navigationItem.rightBarButtonItem = rightButton
    }
    
    @objc func dismissView() {
        dismiss(animated: true, completion: nil)
    }
    
}

// MARK: - Hierarchy and Auto Layout
extension DeetailUserViewController {
    
    private func buildHierarchy() {
        scrollView.addSubview(contentView)
        contentView.addSubview(imageView)
        contentView.addSubview(userLabel)
        contentView.addSubview(usernameLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(placesStack)
        contentView.addSubview(countStack)
        view.addSubview(scrollView)
    }
    
    private func activateConstraints() {
        scrollView.anchor(top: view.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: view.bottomAnchor)
        contentView.dimensionAnchors(height: scrollView.heightAnchor, width: scrollView.widthAnchor)
        contentView.anchor(top: scrollView.topAnchor, leading: scrollView.leadingAnchor, trailing: scrollView.trailingAnchor, bottom: scrollView.bottomAnchor)
        imageView.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, trailing: nil, bottom: nil, padding: .init(top: 102, left: 20, bottom: 0, right: 0))
        userLabel.anchor(top: imageView.bottomAnchor, leading: imageView.leadingAnchor, trailing: view.layoutMarginsGuide.trailingAnchor, bottom: nil, padding: .init(top: 16, left: 0, bottom: 0, right: 0))
        usernameLabel.anchor(top: userLabel.bottomAnchor, leading: userLabel.leadingAnchor, trailing: userLabel.trailingAnchor, bottom: nil, padding: .init(top: 4, left: 0, bottom: 0, right: 0))
        descriptionLabel.anchor(top: usernameLabel.bottomAnchor, leading: usernameLabel.leadingAnchor, trailing: usernameLabel.trailingAnchor, bottom: nil, padding: .init(top: 8, left: 0, bottom: 0, right: 0))
        placesStack.anchor(top: descriptionLabel.bottomAnchor, leading: descriptionLabel.leadingAnchor, trailing: descriptionLabel.trailingAnchor, bottom: nil, padding: .init(top: 8, left: 0, bottom: 0, right: 0))
        countStack.anchor(top: placesStack.bottomAnchor, leading: placesStack.leadingAnchor, trailing: placesStack.trailingAnchor, bottom: nil, padding: .init(top: 8, left: 0, bottom: 0, right: 0))
    }
    
}

// MARK: - Methods
extension DeetailUserViewController {
    
    private func animateViews() {
        UIView.animate(withDuration: 0.3) { [unowned self] in
            self.userLabel.alpha = 1
            self.usernameLabel.alpha = 1
            self.descriptionLabel.alpha = 1
            self.placesStack.alpha = 1
            self.countStack.alpha = 1
        }
    }
    
    private func configure(with user: UserViewModel) {
        userLabel.text = user.name
        usernameLabel.text = user.nickname
        descriptionLabel.text = user.description
        locationLabel.text = user.location
        creationLabel.text = user.creation
        followersLabel.text = "0" + (followersLabel.text ?? "")
        title = user.name
    }
}

// MARK: - ViewModel Binds
extension DeetailUserViewController: FetchableImage {
    
    private func viewModelBinds() {
        viewModel?.user.bind { [weak self] user in
            self?.configure(with: user)
            self?.animateViews()
            self?.fetchImage(from: user.profileImageURL, completion: { data in
                DispatchQueue.main.async {
                    guard let data = data else { return }
                    let image = UIImage(data: data)
                    self?.imageView.image = image
                    UIView.animate(withDuration: 0.3) {
                        self?.imageView.alpha = 1
                    }
                }
            })
        }
    }
    
}
