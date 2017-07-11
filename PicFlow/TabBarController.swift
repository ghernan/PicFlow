//
//  TabBarController.swift
//  PicFlow
//
//  Created by Antonio  Hernandez  on 7/7/17.
//  Copyright © 2017 Antonio  Hernandez . All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    //MARK: Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewControllers = [createFeedController(forTechnology: .ios),
                                createFeedController(forTechnology: .android),
                                createFeedController(forTechnology: .windows)]
        setUpViewControllers()
    }
    
    //MARK: Private methods
    
    private func setUpViewControllers() {
        
        self.viewControllers?.forEach {
            
            let technology = ($0 as! TwitterFeedViewController).technology
            let icon = UITabBarItem(title: "", image: technology?.getLogo(), selectedImage: technology?.getLogo())
            $0.tabBarItem = icon
        }
    }
    
    private func createFeedController(forTechnology technology: TechnologyType) -> TwitterFeedViewController {
        
        if let feedController: TwitterFeedViewController = R.storyboard.feed.feedController() {
            feedController.technology = technology
            return feedController
        }
        return R.storyboard.feed.feedController()!
    }
}
