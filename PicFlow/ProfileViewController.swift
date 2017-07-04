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
    
    //Private properties
    
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
        ImageDownloader.getImage(fromURL: currentUser.imageURL,
                                 success: { image in
                                    
                                    self.profilePicture.image = image
        },
                                 error: {error in
                                    print(error) //TODO: handle with exception
        })
    }

 

}
