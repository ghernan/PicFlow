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

class FBLogin {
    
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
    
    //MARK: - Private methods
    

    
    //MARK: - Public methods
    public func logOut() {
        let loginManager = LoginManager()
        loginManager.logOut()
    }
    public func setCurrentUser(success: @escaping (FBUser) -> (), error: @escaping (Error) -> ()) {
        
        GraphRequest(graphPath: "me", parameters: ["fields":"email, first_name, last_name, picture.type(large)"]).start({ (response, result) in
            
            switch result {
                
            case .failed(let err):
                print(err) // TODO: handle exception
                error(err)
            case .success(let profileResponse):
                if let profileDictionary = profileResponse.dictionaryValue {
                    
                    success(Mapper<FBUser>().map(JSON: profileDictionary)!)
                }
            }
        })
    }
    
}
//MARK: - LoginButtonDelegate
extension FBLogin: LoginButtonDelegate {
    
    public func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult) {
        
        
        Profile.shared.type = .facebook
        
    }
    
    public func loginButtonDidLogOut(_ loginButton: LoginButton) {
        
        
    }
}
