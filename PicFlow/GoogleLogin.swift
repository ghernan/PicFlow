//
//  GoogleLogin.swift
//  PicFlow
//
//  Created by Antonio  Hernandez  on 7/1/17.
//  Copyright © 2017 Antonio  Hernandez . All rights reserved.
//

import GoogleSignIn

class GoogleLogin: NSObject {
    
    //MARK: - Static properties
    static let shared = GoogleLogin()
    
    static let loginButton: GIDSignInButton = {
        let button = GIDSignInButton()
        GIDSignIn.sharedInstance().delegate = shared
        return button
    }()
    
    //Public properties
    public lazy var currentUser: GoogleUser = {
        guard let googleProfile = GIDSignIn.sharedInstance().currentUser.profile else {
            print("Not able to obtain profile") // TODO: handle an exception
            return GoogleUser()
        }
        return GoogleUser(withProfile: googleProfile)
    }()
    
    
    //MARK: - Life cycle
    private override init() {
    
    }
    
    //MARK: - Public methods
    public func logOut() {
        GIDSignIn.sharedInstance().signOut()
    }

    
    
}

//MARK: - GIDSignInDelegate
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

