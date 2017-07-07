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
    
    //MARK: - Public properties
    
    var user: TwitterUser!
    var tweets: [Tweet] = []
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUserProfile()
        loadUserTweets()
        print(user)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let userTimelineViewController = segue.destination as? UserTimelineViewController {
            userTimelineViewController.user =
                sender as? TwitterUser
        }
    }
    
    //MARK: - Private methods
    
    private func setUserProfile() {
        
        userNameLabel.text = user.firstName
        userScreenNameLabel.text = user.userName
        ImageDownloader.getImage(fromURL: user.imageURL,
                                 success: { image in
                                    self.userProfilePicture.image = image
        },
                                 error: {error in
                                    print(error)
        })
        
    }
    
    private func loadUserTweets() {
        
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
//MARK: - UITableViewDatasource
extension UserTimelineViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(userImageTapped(tapGestureRecognizer:)
            ))
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell") as! TweetViewCell
        cell.configure(withTweet: tweets[indexPath.row])
        cell.userImage.tag = indexPath.row
        cell.userImage.addGestureRecognizer(tapGestureRecognizer)
        return cell
    }
}
//MARK: - UITableViewDelegate
extension UserTimelineViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}


