//
//  GoogleUser.swift
//  PicFlow
//
//  Created by Antonio  Hernandez  on 7/3/17.
//  Copyright © 2017 Antonio  Hernandez . All rights reserved.
//
import GoogleSignIn

class GoogleUser: User {
    
    init(withProfile profile: GIDProfileData) {
        
        super.init()
        self.email = profile.email
        self.firstName = profile.givenName
        self.lastName = profile.familyName
        self.userName = profile.name
        self.imageURL = profile.imageURL(withDimension: 1080)
    }
    
    override init() {
        super.init()
    }

}
