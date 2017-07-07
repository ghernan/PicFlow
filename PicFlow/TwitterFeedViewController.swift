//
//  TweeterFeedViewController.swift
//  PicFlow
//
//  Created by Antonio  Hernandez  on 7/4/17.
//  Copyright © 2017 Antonio  Hernandez . All rights reserved.
//

import TwitterKit
import TwitterCore

class TwitterFeedViewController: UIViewController {
    
    //MARK: - Constant properties
    var technology: TechnologyType!
    
    @IBOutlet weak var tweetTableView: UITableView!   
    
    
    //MARK: - Properties
    fileprivate var tweets: [Tweet] = []
    
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(showTweets), for: UIControlEvents.valueChanged)
        
        return refreshControl
    }()
    
    //MARK: - Life Cycle
    override func viewDidLoad() {

        super.viewDidLoad()
        
        tableViewSetup()
        showTweets()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let userTimelineViewController = segue.destination as? UserTimelineViewController {
            userTimelineViewController.user =
            sender as? TwitterUser
        }
    }
    
    //MARK: - Private methods
    private func tableViewSetup() {
        tweetTableView.addSubview(refreshControl)
        tweetTableView.rowHeight = UITableViewAutomaticDimension
        tweetTableView.estimatedRowHeight = 140
        tweetTableView.tableFooterView = UIView()
        
        if( traitCollection.forceTouchCapability == .available){
            
            registerForPreviewing(with: self, sourceView: tweetTableView)           
        }
    }
    
    
    
    @objc private func showTweets() {
        TwitterAPIManager.getTweets(forMobileTechnology: technology, success: { tweets in
            
            self.tweets = tweets
            self.tweetTableView.reloadData()
            self.refreshControl.endRefreshing()
        }, error: { error in
            print(error)
        })
    }
    
    @objc fileprivate func userImageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        if let tweetIndex = tapGestureRecognizer.view?.tag {
            let tweet = tweets[tweetIndex]
            showUserTimeline(user: TwitterUser(withTweet: tweet))
        }
    }
    
    private func showUserTimeline(user: TwitterUser) {
        performSegue(withIdentifier: "toUserTimeline", sender: user)
    }
}



//MARK: - UITableViewDelegate

extension TwitterFeedViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == tweets.count-4 {
            let lastId = Int(tweets[tweets.count-1].id)!-1
            TwitterAPIManager.getTweets(forMobileTechnology: technology, getTweetsOn: .older, startingOnTweetID: "\(lastId)",
                success: { tweets in
                    self.tweets.append(contentsOf: tweets)
                    self.tweetTableView.reloadData()
            },
                error: {error in
                    print(error)
            })
        }
        
    }

}

//MARK: - UITableViewDataSource

extension TwitterFeedViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(userImageTapped(tapGestureRecognizer:)
            ))
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell") as! TweetViewCell
        cell.userImage.tag = indexPath.row
        cell.configure(withTweet: tweets[indexPath.row])
        
        cell.userImage.addGestureRecognizer(tapGestureRecognizer)
        return cell
    }
    
}
//MARK: - UIViewControllerPreviewingDelegate
extension TwitterFeedViewController: UIViewControllerPreviewingDelegate {
    
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
