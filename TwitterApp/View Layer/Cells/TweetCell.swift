//
//  TweetCell.swift
//  TwitterApp
//
//  Created by Abner Castro on 14/08/20.
//  Copyright © 2020 Abner Castro. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class TweetCell: UITableViewCell, FetchableImage {
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    let newImageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 25
        image.clipsToBounds = true
        image.image = .init(assetIdenfier: .gato)
        return image
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica-Bold", size: 12)
        label.textColor = UIColor.black
        label.text = "Nombre del usuario"
        return label
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 10)
        label.textColor = UIColor.systemGray
        label.text = "@username"
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 12)
        label.textColor = UIColor.black
        label.numberOfLines = 0
        label.text = "iPhone, iPad, iOS Programming Community. Join us to learn Swift, Objective-C and build iOS apps!"
        return label
    }()
    
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
    
    var shareTapped = PublishSubject<String>()
    var viewModel = ReplaySubject<TweetViewModel>.create(bufferSize: 1)
    let bag = DisposeBag()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        activateConstraints()
        bindings()
    }
    
    func configure(with vm: TweetViewModel) {
        viewModel.onNext(vm)
    }
    
    private func bindings() {
        viewModel.subscribe(onNext: { [weak self] vm in
            guard let self = self else { return }
            self.titleLabel.text = vm.user.name
            self.subtitleLabel.text = vm.user.nickname
            self.descriptionLabel.text = vm.text
            self.shareButton.addTarget(self, action: #selector(self.shareAction), for: .touchUpInside)
            self.fetchImage(withIdentifier: vm.user.profileImageURL)
            }).disposed(by: bag)
    }
    
    private func fetchImage(withIdentifier identifier: String) {
        fetchImage(from: identifier) { [weak self] data in
            guard let data = data else { return }
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                self?.newImageView.alpha = 0
                self?.newImageView.image = image
                UIView.animate(withDuration: 0.3) {
                    self?.newImageView.alpha = 1
                }
            }
        }
    }
    
    @objc func shareAction() {
        viewModel.subscribe(onNext: { [weak self] vm in
            guard let self = self else { return }
            self.shareTapped.onNext(vm.text)
            })
            .disposed(by: bag)
    }
}

// MARK: - Setup Views
extension TweetCell {
    
    private func addSubviews() {
        addSubview(newImageView)
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        addSubview(descriptionLabel)
        addSubview(buttonsStack)
    }
    
    private func activateConstraints() {
        newImageView.anchor(top: topAnchor, leading: leadingAnchor, trailing: nil, bottom: nil, padding: .init(top: 12, left: 12, bottom: 0, right: 0), size: .init(width: 50, height: 50))
        titleLabel.anchor(top: newImageView.topAnchor, leading: newImageView.trailingAnchor, trailing: trailingAnchor, bottom: nil, padding: .init(top: 0, left: 4, bottom: 0, right: 12), size: .init(width: 0, height: 20))
        subtitleLabel.anchor(top: titleLabel.bottomAnchor, leading: titleLabel.leadingAnchor, trailing: titleLabel.trailingAnchor, bottom: nil, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 20))
        descriptionLabel.anchor(top: subtitleLabel.bottomAnchor, leading: subtitleLabel.leadingAnchor, trailing: subtitleLabel.trailingAnchor, bottom: nil, padding: .init(top: 4, left: 0, bottom: 8, right: 0))
        buttonsStack.anchor(top: descriptionLabel.bottomAnchor, leading: descriptionLabel.leadingAnchor, trailing: descriptionLabel.trailingAnchor, bottom: bottomAnchor, padding: .init(top: 16, left: 0, bottom: 16, right: 0))
    }
    
}
