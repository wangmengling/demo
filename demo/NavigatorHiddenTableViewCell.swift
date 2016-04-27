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
        MLImageDowloader.defaultDownloader.downloaderImage(NSURL(string: "http://upload.jianshu.io/users/upload_avatars/1170347/1b89e007629e?imageMogr/thumbnail/90x90/quality/100")!) { (image, error, imageURL, originalData) in
            
        }
    }
}
