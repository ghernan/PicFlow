//
//  Profile.swift
//  PicFlow
//
//  Created by Antonio  Hernandez  on 7/2/17.
//  Copyright © 2017 Antonio  Hernandez . All rights reserved.
//
import ObjectMapper
import FacebookCore
import TwitterKit
import GoogleSignIn

class Profile {
    
    //MARK: - Enumerations
    enum ProfileType : Int {
        
        case facebook
        case google
        case twitter
        case none
        
    }
    
    //MARK: - Singleton
    static let shared = Profile()
    
    //MARK: - Variable properties
    var type: ProfileType = .none {
        
        didSet {
            setUserProfile()
        }
    }
    
    var me: User = User() {
        
        didSet {
            
            if let didLoggedIn = didLoggedIn?(true) {
                didLoggedIn
            }
        }
    }
    
    var didLoggedIn: ((_ loggedIn: Bool) -> Void)?
    
    //MARK: - Life cycle
    private init() {
        
    }
    
    //MARK: - Private methods
    private func setUserProfile(){
        switch type {
            
        case .facebook:
            getFacebookProfile()
            break
        case .google:
            getGoogleProfile()
            break
        case .twitter:
            getTwitterProfile()
            break
           
        default: break
        }
    }
    
    private func getFacebookProfile() {
        
        FBLogin.shared.setCurrentUser(success: { (user) in
            self.me = user
        }, error: { (error) in
            print(error)
        })        
    }
    
    private func getTwitterProfile() {
        
        TwitterLogin.shared.setCurrentUser(success: { (user) in
            self.me = user
        }, error: { (error) in
            print(error)
        })

    }
    
    private func getGoogleProfile() {
        
        me = GoogleLogin.shared.currentUser
    }
    
    //MARK - Public Methods
    
    public func loggedIn() -> Bool {
        
        if let _ = GIDSignIn.sharedInstance().currentUser {
            type = .google            
            return true
        }
        if let _ = AccessToken.current {
            type = .facebook
            return true
        }
        if let _ = Twitter.sharedInstance().sessionStore.session() {
            type = .twitter
            return true
        }
        return false
    
    }
    
    public func logOut() {
        
        switch type {
        case .facebook:
            FBLogin.shared.logOut()
            break
        case .google:
            GoogleLogin.shared.logOut()
            break
        case .twitter:
            TwitterLogin.shared.logOut()
            break
        default:
            break
        }
    }
    
    
    
    
    
    
    
}
