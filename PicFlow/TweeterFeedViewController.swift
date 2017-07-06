//
//  TweeterFeedViewController.swift
//  PicFlow
//
//  Created by Antonio  Hernandez  on 7/4/17.
//  Copyright © 2017 Antonio  Hernandez . All rights reserved.
//

import TwitterKit
import TwitterCore

class TweeterFeedViewController: UIViewController {
    
    //MARK: - Constant properties
    
    
    @IBOutlet weak var tweetTableView: UITableView!
    //MARK: - Properties
    fileprivate var tweets: [TWTRTweet] = []
    
    override func viewDidLoad() {

        super.viewDidLoad()
        TwitterAPIManager.getTweets(forMobileTechnology: "android", success: { tweets in
            print(tweets[0].name)
            print(tweets[0].userScreenName)
            print(tweets[0].mediaURL)
            print(tweets[0].relativeDate)
            print(tweets[0].text)
            print(tweets[0].userImageURL)
            print(tweets[0].userID)
            print(tweets[1].name)
            print(tweets[1].userScreenName)
            print(tweets[1].mediaURL)
            print(tweets[1].relativeDate)
            print(tweets[1].text)
            print(tweets[1].userImageURL)
            print(tweets[1].userID)
        }, error: { error in
        
        })
        if( traitCollection.forceTouchCapability == .available){
            print("AVAILABLE")
            registerForPreviewing(with: self, sourceView: tweetTableView)
            
        }
        let client = TWTRAPIClient()
        let tweetIDs = ["20", "21", "22", "510908133917487104"]
        
        tweetTableView.rowHeight = UITableViewAutomaticDimension
        tweetTableView.estimatedRowHeight = 140
        client.loadTweets(withIDs: tweetIDs) { (tweets, error) in
            if let tweets = tweets {
                self.tweets = tweets
                
                self.tweetTableView.reloadData()
                
            } else {
                print(error!)
            }
        }
    }
}

//MARK: - UITableViewDelegate

extension TweeterFeedViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        
        return 100
    }

}

//MARK: - UITableViewDataSource

extension TweeterFeedViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell") as! TweetViewCell
        cell.configure(withTweet: tweets[indexPath.row])
        cell.isUserInteractionEnabled = true
        cell.tweetImage.isUserInteractionEnabled = true
        cell.userImage.isUserInteractionEnabled = true
        return cell
    }
    
}

extension TweeterFeedViewController: UIViewControllerPreviewingDelegate {
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        
        show(viewControllerToCommit, sender: self)
        
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        
        guard let indexPath = tweetTableView?.indexPathForRow(at: location) else {
            return nil
        }
        
        let cell = tweetTableView.cellForRow(at: indexPath) as! TweetViewCell
        
        let detailVC = PopUpViewController()
        
        
        detailVC.image = cell.tweetImage.image
        
        detailVC.preferredContentSize = CGSize(width: 0.0, height: 300)
        
        previewingContext.sourceRect = cell.frame
        
        return detailVC
        
    }

}
