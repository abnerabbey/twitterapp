//
//  PhotosCell.swift
//  TwitterApp
//
//  Created by Abner Castro on 24/08/20.
//  Copyright © 2020 Abner Castro. All rights reserved.
//

import UIKit

class PhotosCell: UICollectionViewCell {
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    let newImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubviews()
        activateConstraints()
    }
    
    func flash() {
        newImageView.alpha = 0
        setNeedsDisplay()
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.newImageView.alpha = 1
        }
    }
    
}

// MARK: - View Hierarchy and Constraints
extension PhotosCell {
    
    private func addSubviews() {
        addSubview(newImageView)
    }
    
    private func activateConstraints() {
        newImageView.anchor(top: topAnchor, leading: leadingAnchor, trailing: trailingAnchor, bottom: bottomAnchor)
    }
    
}
