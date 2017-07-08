//
//  UserTimelineViewController.swift
//  PicFlow
//
//  Created by Antonio  Hernandez  on 7/6/17.
//  Copyright © 2017 Antonio  Hernandez . All rights reserved.
//

import UIKit

class UserTimelineViewController: UIViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var userProfilePicture: UIImageView!
    
    @IBOutlet weak var userNameLabel: UILabel!
    
    @IBOutlet weak var userScreenNameLabel: UILabel!
    
    @IBOutlet weak var tableviewTimeline: UITableView!
    
    
    //MARK: - Public properties
    
    var user: TwitterUser!
    
    
    //MARK: - Private properties
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(loadUserTweets), for: UIControlEvents.valueChanged)
        
        return refreshControl
    }()
    private var longPressGestureRecognizer: UILongPressGestureRecognizer!
    private var isForceTouchAble = true

    fileprivate var tweets: [Tweet] = []
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableViewSetup()
        setUserProfile()
        loadUserTweets()
        
    }
    
    
    
    //MARK: - Private methods
    
    private func setUserProfile() {
        userProfilePicture.layer.cornerRadius = userProfilePicture.frame.height/2
        userProfilePicture.layer.masksToBounds = true
        userNameLabel.text = user.firstName
        userScreenNameLabel.text = user.userName
        ImageDownload.getImage(fromURL: user.imageURL,
                                 success: { image in
                                    self.userProfilePicture.image = image
        },
                                 error: {error in
                                    print(error)
        })
        
    }
    
    private func tableViewSetup() {
        tableviewTimeline.addSubview(refreshControl)
        tableviewTimeline.rowHeight = UITableViewAutomaticDimension
        tableviewTimeline.estimatedRowHeight = 140
        tableviewTimeline.tableFooterView = UIView()
        
        if( traitCollection.forceTouchCapability == .available){
            
            registerForPreviewing(with: self, sourceView: tableviewTimeline)
        }
    }
    
    @objc private func loadUserTweets() {
        
        TwitterAPIManager.getTweets(fromUser: user.userName,
                                    success: { tweets in
                                        self.tweets = tweets
                                        
                                        self.tableviewTimeline.reloadData()
                                        self.refreshControl.endRefreshing()
        },
                                    error: { error in
                                        print(error)
                                        
        })
    }
    

}
//MARK: - UITableViewDatasource
extension UserTimelineViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: TweetViewCell.reusableIdentifier) as! TweetViewCell
        cell.configure(withTweet: tweets[indexPath.row])
       
        return cell
    }
}
//MARK: - UITableViewDelegate
extension UserTimelineViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row == tweets.count-4 {
            guard let lastId = tweets.last?.id else {
                return
            }
            guard let cursorId = Int64(lastId) else {
                return
            }
            let maxId = cursorId - 1
            TwitterAPIManager.getTweets(fromUser: user.userName, getTweetsOn: .older, startingOnTweetID: "\(maxId)",
                success: { tweets in
                    self.tweets.append(contentsOf: tweets)
                    self.tableviewTimeline.reloadData()
            },
                error: {error in
                    print(error)
            })
        }
        
    }
    
}

//MARK: - UIViewControllerPreviewingDelegate
extension UserTimelineViewController: UIViewControllerPreviewingDelegate {
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
        
        show(viewControllerToCommit, sender: self)
        
    }
    
    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        
        guard let indexPath = tableviewTimeline?.indexPathForRow(at: location) else {
            return nil
        }
        
        let cell = tableviewTimeline.cellForRow(at: indexPath) as! TweetViewCell
        
        let detailVC = PopUpViewController()
        
        detailVC.image = cell.tweetImage.image
        
        detailVC.preferredContentSize = CGSize(width: 0.0, height: 300)
        
        previewingContext.sourceRect = cell.frame
        
        return detailVC
        
    }
    
}


