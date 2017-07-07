//
//  TwitterUser.swift
//  PicFlow
//
//  Created by Antonio  Hernandez  on 7/4/17.
//  Copyright © 2017 Antonio  Hernandez . All rights reserved.
//

import TwitterKit
import TwitterCore

class TwitterUser: User {
    
    
    
    init(withProfile profile: TWTRUser) {
        
        super.init()
        
        self.firstName = profile.name
        self.lastName = ""
        self.userName = profile.screenName
        self.imageURL = URL(string: profile.profileImageLargeURL)!
    }
    
    override init() {
        super.init()
    }
    
    init(withTweet tweet: Tweet) {
        super.init()
        self.firstName = tweet.name
        self.lastName = ""
        self.userName = tweet.userScreenName
        self.imageURL = tweet.userImageURL
    }
    
}
