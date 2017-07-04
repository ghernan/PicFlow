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
    
    //MARK: - Static properties
    static let shared = TwitterLogin()
    static let loginButton = TWTRLogInButton { (session, error) in
        guard let session = session else {
            print(error!)
            return
        }
        Profile.shared.type = .twitter
    }
    
    //MARK: Public properties
    
    
    //MARK: - Life cycle
    private init() {
        
    }
    
    
    
    //MARK: - Public methods
    public func setCurrentUser(success: @escaping (TwitterUser) -> (), error: @escaping (Error) -> ()) {
        
        let twitterClient = TWTRAPIClient.withCurrentUser()
        guard let id = twitterClient.userID else {
            return
        }
        
        twitterClient.loadUser(withID: id, completion: { profile, err in
            guard let profile = profile else {
                error(err!)
                return
            }
            twitterClient.requestEmail { email, err  in
                guard let email = email else {
                    print("error: \(err!.localizedDescription)")
                    error(err!)
                    return
                }
            }
            success(TwitterUser(withProfile: profile))
        })
    }
    
    public func logOut() {
        
        let store = Twitter.sharedInstance().sessionStore
        
        if let userID = store.session()?.userID {
            store.logOutUserID(userID)
        }
    }
}

