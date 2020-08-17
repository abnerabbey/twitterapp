//
//  TweetCell.swift
//  TwitterApp
//
//  Created by Abner Castro on 14/08/20.
//  Copyright © 2020 Abner Castro. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

    @IBOutlet weak var newImageView: UIImageView! {
        didSet {
            newImageView.layer.cornerRadius = 12
        }
    }
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    func configure(with vm: TweetViewModel) {
        titleLabel.text = vm.user.nickname
        subtitleLabel.text = vm.text
    }
}
