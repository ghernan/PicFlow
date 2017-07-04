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
            
            didLoggedIn!(true)
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
        
        GraphRequest(graphPath: "me", parameters: ["fields":"email, first_name, last_name, picture.type(large)"]).start({ (response, result) in
            
            switch result {
                
            case .failed(let error):
                print(error)
            case .success(let profileResponse):
                if let profileDictionary = profileResponse.dictionaryValue {
                    
                    self.me = Mapper<FBUser>().map(JSON: profileDictionary)!
                    print(Profile.shared.me.email)
                }
            }
        })
    }
    
    private func getTwitterProfile() {
        
        
        
    }
    
    private func getGoogleProfile() {
        
        guard let googleProfile = GIDSignIn.sharedInstance().currentUser.profile else {
            print("Not able to obtain profile") // TODO: handle an exception
            return
        }
        me = GoogleUser(withProfile: googleProfile)
        print(Profile.shared.me.email)
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
    
    
    
    
    
    
    
}
