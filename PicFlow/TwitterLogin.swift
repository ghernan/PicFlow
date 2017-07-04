//
//  TwitterLogin.swift
//  PicFlow
//
//  Created by Antonio  Hernandez  on 7/1/17.
//  Copyright © 2017 Antonio  Hernandez . All rights reserved.
//

import Foundation
import TwitterKit

class TwitterLogin {
    
    static let shared = TwitterLogin()
    static let loginButton = TWTRLogInButton { (session, error) in
        guard let session = session else {
            print(error!)
            return
        }
        print(session.userName)
        
        
        
        print()
    }
    
    private init() {
        
    }
}

