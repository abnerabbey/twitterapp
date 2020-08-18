//
//  TweetCell.swift
//  TwitterApp
//
//  Created by Abner Castro on 14/08/20.
//  Copyright © 2020 Abner Castro. All rights reserved.
//

import UIKit

final class TweetCell: UITableViewCell {
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
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubviews()
        activateConstraints()
    }
    
    
    
    func configure(with vm: TweetViewModel) {
        titleLabel.text = vm.user.name
        subtitleLabel.text = vm.user.nickname
        descriptionLabel.text = vm.text
    }
}

// MARK: - Setup Views
extension TweetCell {
    
    private func addSubviews() {
        addSubview(newImageView)
        addSubview(titleLabel)
        addSubview(subtitleLabel)
        addSubview(descriptionLabel)
    }
    
    private func activateConstraints() {
        newImageView.anchor(top: topAnchor, leading: leadingAnchor, trailing: nil, bottom: nil, padding: .init(top: 12, left: 12, bottom: 0, right: 0), size: .init(width: 50, height: 50))
        titleLabel.anchor(top: newImageView.topAnchor, leading: newImageView.trailingAnchor, trailing: trailingAnchor, bottom: nil, padding: .init(top: 0, left: 4, bottom: 0, right: 12), size: .init(width: 0, height: 20))
        subtitleLabel.anchor(top: titleLabel.bottomAnchor, leading: titleLabel.leadingAnchor, trailing: titleLabel.trailingAnchor, bottom: nil, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 20))
        descriptionLabel.anchor(top: subtitleLabel.bottomAnchor, leading: subtitleLabel.leadingAnchor, trailing: subtitleLabel.trailingAnchor, bottom: bottomAnchor, padding: .init(top: 4, left: 0, bottom: 8, right: 0))
    }
    
}
