//
//  ViewController.swift
//  PicFlow
//
//  Created by Antonio  Hernandez  on 6/28/17.
//  Copyright © 2017 Antonio  Hernandez . All rights reserved.
//

import UIKit
import FacebookLogin
import FacebookCore
import TwitterKit
import GoogleSignIn

class LogInViewController: UIViewController {
    
    // MARK: - Injections
    internal let fbLogin = FBLogin.shared
    internal let twitterLogin = TwitterLogin.shared
    internal let googleLogin = GoogleLogin.shared
    
    // MARK: - ViewController Life cycle
    override func viewDidLoad() {
        
        prepareButtons()
        hasLoggedIn()
    }
    
    // MARK: - Private functions
    private func prepareButtons() {
        
        let fbLoginButton = FBLogin.loginButton
        let twitterLoginButton = TwitterLogin.loginButton
        let googleLoginButton = GoogleLogin.loginButton
        GIDSignIn.sharedInstance().uiDelegate = self
        twitterLoginButton.center = CGPoint(x: view.center.x, y: view.center.y + 150)
        googleLoginButton.center = CGPoint(x: view.center.x, y: view.center.y - 150)
        fbLoginButton.center = view.center
        view.addSubview(fbLoginButton)
        view.addSubview(twitterLoginButton)
        view.addSubview(googleLoginButton)
    }
    
    private func hasLoggedIn() {
        
        Profile.shared.didLoggedIn = { loggedIn in
            
            self.performSegue(withIdentifier: R.segue.logInViewController.toFeed, sender: self)
        }
    }
    
}

//MARK: - GIDSignInUIDelegate 

extension LogInViewController: GIDSignInUIDelegate {
    
    func sign(_ signIn: GIDSignIn!, present viewController: UIViewController!) {
        
        self.present(viewController, animated: true, completion: nil)
    }
    
    func sign(_ signIn: GIDSignIn!, dismiss viewController: UIViewController!) {
        
        self.dismiss(animated: true, completion: nil)
    }
}



