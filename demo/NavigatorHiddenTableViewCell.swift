//
//  NavigatorHiddenTableViewCell.swift
//  demo
//
//  Created by apple on 16/4/26.
//  Copyright © 2016年 jackWang. All rights reserved.
//

import UIKit

class NavigatorHiddenTableViewCell: UITableViewCell {
    var topicsModel:TopicsModel?
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
//        self.avatarImageView.image = UIImage()
        self.titleLabel.text = self.topicsModel?.title
    }
}
