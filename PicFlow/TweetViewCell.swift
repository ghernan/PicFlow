//
//  TweetViewCell.swift
//  PicFlow
//
//  Created by Antonio  Hernandez  on 7/6/17.
//  Copyright © 2017 Antonio  Hernandez . All rights reserved.
//

import TwitterKit

class TweetViewCell: UITableViewCell {
    
    
    @IBOutlet weak var userImage: UIImageView!

    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    
    @IBOutlet weak var tweetLabel: UILabel!
    
    @IBOutlet weak var tweetImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        nameLabel.sizeToFit()
        timeLabel.sizeToFit()
        
        // Initialization code
    }
    
    func configure(withTweet tweet: TWTRTweet) {
        nameLabel.text = tweet.author.name
        userNameLabel.text = tweet.author.screenName
        tweetLabel.text = tweet.text
        ImageDownloader.getImage(fromURL: URL(string: tweet.author.profileImageMiniURL)!, success: { image in
            self.userImage.image = image
            
            }, error: { error in
            print(error)
        })
    
    }

    

}
