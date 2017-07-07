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
        
        
        // Initialization code
    }
    
    func configure(withTweet tweet: Tweet) {
        
        self.selectionStyle = .none
        userImage.layer.masksToBounds = true
        userImage.layer.cornerRadius = userImage.frame.height/2
        nameLabel.text = tweet.name
        userNameLabel.text = "@\(tweet.userScreenName)"
        tweetLabel.text = tweet.text
        timeLabel.text = tweet.relativeDate
        
        ImageDownload.getImage(fromURL: tweet.userImageURL, success: { profileImage in
            
            ImageDownload.getImage(fromURL: tweet.mediaURL, success: { media in
                
                DispatchQueue.main.async {
                    
                    self.userImage.image = profileImage
                    self.tweetImage.image = media
                    
                }
                
                
            }, error: { (error) in
                print(error)
            })
        }, error: { error in
            print(error)
        })
    
    }

    

}
