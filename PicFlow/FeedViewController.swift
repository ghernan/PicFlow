//
//  FeedViewController.swift
//  PicFlow
//
//  Created by Antonio  Hernandez  on 7/5/17.
//  Copyright © 2017 Antonio  Hernandez . All rights reserved.
//

import UIKit
import TwitterKit

class FeedViewController: TWTRTimelineViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let client = TWTRAPIClient()
        self.dataSource = TWTRSearchTimelineDataSource(searchQuery:"android filter:images", apiClient: client)
        
        
    }



}
