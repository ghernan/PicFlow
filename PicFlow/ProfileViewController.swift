//
//  ProfileViewController.swift
//  PicFlow
//
//  Created by Antonio  Hernandez  on 7/3/17.
//  Copyright © 2017 Antonio  Hernandez . All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    //MARK: - IBOutlets
    
    @IBOutlet weak var profilePicture: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var emailLabel: UILabel!
    
    //MARK: - IBActions
    
    @IBAction func logOut(_ sender: Any) {
        
        present(R.storyboard.main.instantiateInitialViewController()!, animated: true, completion: {
            self.profile.logOut()
        })
//        self.navigationController?.dismiss(animated: true, completion: {
//            self.profile.logOut()
//        })
    }
    
    
    //Private properties
    private let profile = Profile.shared
    private let currentUser = Profile.shared.me
    
    
    // MARK: - ViewController life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setRoundedProfilePic()
        setUIWithCurrentUser()
    }
    
    //MARK: - Private functions
    private func setRoundedProfilePic() {
        profilePicture.layer.borderWidth = 1
        profilePicture.layer.masksToBounds = true
        profilePicture.layer.borderColor = UIColor.orange.cgColor
        profilePicture.layer.cornerRadius = profilePicture.frame.height/2
    }
    
    private func setUIWithCurrentUser() {
        
        userNameLabel.text = currentUser.userName
        nameLabel.text = "\(currentUser.firstName) \(currentUser.lastName)"
        emailLabel.text = currentUser.email
        ImageDownload.getImage(fromURL: currentUser.imageURL,
                                 success: { image in
                                    
                                    self.profilePicture.image = image
        },
                                 error: {error in
                                    print(error) //TODO: handle with exception
        })
    }

 

}
