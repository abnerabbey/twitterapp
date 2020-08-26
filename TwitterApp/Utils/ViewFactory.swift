//
//  ViewFactory.swift
//  TwitterApp
//
//  Created by Abner Castro on 26/08/20.
//  Copyright © 2020 Abner Castro. All rights reserved.
//

import Foundation
import UIKit

class ViewFactory {
    
    static let contentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica-light", size: 17)
        label.numberOfLines = 0
        label.textColor = .black
        return label
    }()
    
    static let dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 11)
        label.numberOfLines = 1
        label.textColor = .systemGray
        return label
    }()
    
    static let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    static let separationView: () -> UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray5
        return view
    }
    
    static let infoLabel: () -> UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 12)
        label.numberOfLines = 1
        label.textColor = .systemGray
        return label
    }
    
    static let horizontalStack: ([UIView]) -> UIStackView = {
        let stack = UIStackView(arrangedSubviews: $0)
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        return stack
    }
    
    static let buttonImage: (UIImage.AssetIdentifier) -> UIButton = {
        let button = UIButton(type: .system)
        button.setImage(.init(assetIdenfier: $0), for: .normal)
        button.tintColor = .redMain
        return button
    }
    
    static let cellImageView: () -> UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 25
        image.clipsToBounds = true
        image.image = .init(assetIdenfier: .gato)
        return image
    }
    
    static let cellTitleLabel: () -> UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica-Bold", size: 12)
        label.textColor = UIColor.black
        label.text = "Nombre del usuario"
        return label
    }
    
    static let cellSubtitleLabel: () -> UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 10)
        label.textColor = UIColor.systemGray
        label.text = "@username"
        return label
    }
    
    static let cellDescriptionLabel: () -> UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica", size: 12)
        label.textColor = UIColor.black
        label.numberOfLines = 0
        label.text = "iPhone, iPad, iOS Programming Community. Join us to learn Swift, Objective-C and build iOS apps!"
        return label
    }
}
