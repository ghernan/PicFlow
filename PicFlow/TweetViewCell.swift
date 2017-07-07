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
    
    func configure(withTweet tweet: Tweet) {
        userImage.layer.masksToBounds = true
        userImage.layer.cornerRadius = userImage.frame.height/2
        nameLabel.text = tweet.name
        userNameLabel.text = "@\(tweet.userScreenName)"
        tweetLabel.text = tweet.text
        ImageDownloader.getImage(fromURL: tweet.userImageURL, success: { profileImage in
            self.userImage.image = profileImage
            ImageDownloader.getImage(fromURL: tweet.mediaURL, success: { media in
                self.tweetImage.image = media
            }, error: { (error) in
                print(error)
            })
        }, error: { error in
            print(error)
        })
    
    }

    

}
