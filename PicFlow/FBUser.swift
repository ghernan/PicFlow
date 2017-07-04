//
//  FBUser.swift
//  PicFlow
//
//  Created by Antonio  Hernandez  on 7/2/17.
//  Copyright © 2017 Antonio  Hernandez . All rights reserved.
//

import ObjectMapper

class FBUser: User {
    
    required init?(map: Map) {
        super.init()
        mapping(map: map)
    } 
}

extension FBUser: Mappable {
    
    func mapping(map: Map) {
        
        email        <- map["email"]
        userName     <- map["first_name"]
        firstName    <- map["first_name"]
        lastName     <- map["last_name"]
        imageURL     <- (map["picture.data.url"], URL.transform)
    }
    
}

