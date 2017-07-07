//
//  TabBarController.swift
//  PicFlow
//
//  Created by Antonio  Hernandez  on 7/7/17.
//  Copyright © 2017 Antonio  Hernandez . All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let iOSViewController: TwitterFeedViewController = UIStoryboard(name: "Feed", bundle: nil).instantiateViewController(withIdentifier: "feedController")  as! TwitterFeedViewController
        let androidViewController: TwitterFeedViewController = UIStoryboard(name: "Feed", bundle: nil).instantiateViewController(withIdentifier: "feedController")  as! TwitterFeedViewController
        let windowsViewController: TwitterFeedViewController = UIStoryboard(name: "Feed", bundle: nil).instantiateViewController(withIdentifier: "feedController")  as! TwitterFeedViewController
        iOSViewController.technology = .ios
        androidViewController.technology = .android
        windowsViewController.technology = .windows
        self.viewControllers = [iOSViewController, androidViewController, windowsViewController]
        setUpViewControllers()
    }
    
    private func setUpViewControllers() {
        self.viewControllers?.forEach {
            $0.title = ($0 as! TwitterFeedViewController).technology.getHashTag()
        }
    }

    

}
