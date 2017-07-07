//
//  PopUpViewController.swift
//  PicFlow
//
//  Created by Antonio  Hernandez  on 7/6/17.
//  Copyright © 2017 Antonio  Hernandez . All rights reserved.
//

import UIKit

class PopUpViewController: UIViewController {

    var image: UIImage?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let image = image {
            let imageView = UIImageView(image: image)
            imageView.frame.size.height = 200.0
            imageView.frame.size.width = 300.0
            self.automaticallyAdjustsScrollViewInsets = false
            imageView.center = view.center
            self.view.addSubview(imageView)
        }       

    }

}
