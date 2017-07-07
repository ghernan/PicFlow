//
//  Tweet.swift
//  PicFlow
//
//  Created by Antonio  Hernandez  on 7/6/17.
//  Copyright © 2017 Antonio  Hernandez . All rights reserved.
//

import ObjectMapper

class Tweet: Mappable {
    
    var name = ""
    var userScreenName = ""
    var relativeDate = ""
    var userID = ""
    var text = ""
    var user = TwitterUser()
    var mediaURL = URL(string: "https://cdn4.iconfinder.com/data/icons/virtual-keyboard/512/user-login-man-person-512.png")!
    var userImageURL = URL(string: "https://cdn4.iconfinder.com/data/icons/virtual-keyboard/512/user-login-man-person-512.png")!
    
    required init?(map: Map) {
        
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        
        name            <- map["user.name"]
        userScreenName  <- map["user.screen_name"]
        userID          <- map["user.id_str"]
        relativeDate    <- map["created_at"]
        text            <- map["text"]
        userImageURL    <- (map["user.profile_image_url"], URL.transform)
        mediaURL        <- (map["entities.media.0.media_url_https"], URL.transform)       
    }
    

}



