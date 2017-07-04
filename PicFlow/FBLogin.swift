//
//  FBLogIn.swift
//  PicFlow
//
//  Created by Antonio  Hernandez  on 6/28/17.
//  Copyright © 2017 Antonio  Hernandez . All rights reserved.
//

import Foundation
import FacebookLogin
import FacebookCore
import ObjectMapper

public class FBLogin {
    
    // MARK: - Static properties
    static let shared = FBLogin()    
    static let loginButton: LoginButton = {
        let button = LoginButton(readPermissions:[.publicProfile, .email])
        button.delegate = shared
        return button
    }()
    
    
    
    // MARK: - Life cycle
    private init() {
        
    }
    
}

extension FBLogin: LoginButtonDelegate {
    
    public func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult) {
        
        
        Profile.shared.type = .facebook
        
    }
    
    public func loginButtonDidLogOut(_ loginButton: LoginButton) {
        
        
    }
}
