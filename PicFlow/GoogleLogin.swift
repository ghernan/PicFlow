//
//  GoogleLogin.swift
//  PicFlow
//
//  Created by Antonio  Hernandez  on 7/1/17.
//  Copyright © 2017 Antonio  Hernandez . All rights reserved.
//

import GoogleSignIn

class GoogleLogin: NSObject {

    static let shared = GoogleLogin()
    static let loginButton: GIDSignInButton = {
        let button = GIDSignInButton()
        GIDSignIn.sharedInstance().delegate = shared
        return button
    }()
    
    
    private override init() {
    
    }
    
    
    
}

extension GoogleLogin: GIDSignInDelegate {
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if (error != nil) {
            print("\(error.localizedDescription)")
            return
        }
        Profile.shared.type = .google
       
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!, withError error: Error!) {
        //
    }
}

