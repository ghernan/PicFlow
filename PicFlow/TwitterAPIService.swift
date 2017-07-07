//
//  TwitterAPIService.swift
//  PicFlow
//
//  Created by Antonio  Hernandez  on 7/6/17.
//  Copyright © 2017 Antonio  Hernandez . All rights reserved.
//

import TwitterKit

class TwitterAPIService {

    private static let client = TWTRAPIClient()
    private static let tweetsEndpoint = "https://api.twitter.com/1.1/search/tweets.json"
    private static let userTimelineEndpoint = "https://api.twitter.com/1.1/statuses/user_timeline.json"
    
    static func requestTweets(forMobileTechnology technology: String, success: @escaping (_ dictionary: [String : Any]) -> (), error: @escaping (_ error: Error) -> ()) {
        
        let params = ["q": "'\(technology)' filter:images", "count": "20"]
        var clientError: NSError?
        let request = client.urlRequest(withMethod: "GET", url: tweetsEndpoint, parameters: params, error: &clientError)
        
        client.sendTwitterRequest(request) { (response, data, connectionError) -> Void in
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
    
    static func requestUserTimeline(withUserName username: String, success: @escaping (_ dictionaryArray: [[String : Any]]) -> (), error: @escaping (_ error: Error) -> ()) {
        
        let params = ["screen_name": "\(username)", "count": "20"]
        var clientError: NSError?
        let request = client.urlRequest(withMethod: "GET", url: userTimelineEndpoint, parameters: params, error: &clientError)
        
        client.sendTwitterRequest(request) { (response, data, connectionError) -> Void in
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
