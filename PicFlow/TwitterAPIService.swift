//
//  TwitterAPIService.swift
//  PicFlow
//
//  Created by Antonio  Hernandez  on 7/6/17.
//  Copyright © 2017 Antonio  Hernandez . All rights reserved.
//

import TwitterKit

class TwitterAPIService {

    
    static func requestTweets(forMobileTechnology technology: TechnologyType, getTweetsOn time: TweetTimeType = .none, startingOnTweetID id: String = "", success: @escaping (_ dictionary: [String : Any]) -> (), error: @escaping (_ error: Error) -> ()) {
        
        guard let request = try? TwitterAPIRouter.getTweets(forTechnologyType: technology, getTweetsOn: time, startingOnTweetID: "").asURLRequest() else {
            return
        }
        
        TwitterAPI.client.sendTwitterRequest(request) { (response, data, connectionError) -> Void in
            if let connectionError = connectionError {
                print("Error: \(connectionError)")
                error(connectionError)
            }
            
            do {
                let dictionary = try JSONSerialization.jsonObject(with: data!, options: []) as! [String : Any]
                success(dictionary)
            } catch let jsonError as NSError {
                print("json error: \(jsonError.localizedDescription)")
                error(jsonError)
            }
        }        
    }
    
    static func requestUserTimeline(withUserName username: String, getTweetsOn time: TweetTimeType = .none, startingOnTweetID id: String = "", success: @escaping (_ dictionaryArray: [[String : Any]]) -> (), error: @escaping (_ error: Error) -> ()) {
        
        guard let request = try? TwitterAPIRouter.getTimelineTweets(fromUser: username, getTweetsOn: time, startingOnTweetID: id).asURLRequest() else {
            return
        }
        
        TwitterAPI.client.sendTwitterRequest(request) { (response, data, connectionError) -> Void in
            if let connectionError = connectionError {
                print("Error: \(connectionError)")
                error(connectionError)
            }
            
            do {
                let dictionary = try JSONSerialization.jsonObject(with: data!, options: []) as! [[String : Any]]
                success(dictionary)
            } catch let jsonError as NSError {
                print("json error: \(jsonError.localizedDescription)")
                error(jsonError)
            }
        }
    }

}
