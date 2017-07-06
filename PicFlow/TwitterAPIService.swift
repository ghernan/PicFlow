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
    private static let statusesShowEndpoint = "https://api.twitter.com/1.1/search/tweets.json"
    
    static func requestTweets(forMobileTechnology technology: String, success: @escaping (_ dictionary: [String : Any?]) -> (), error: @escaping (_ error: Error) -> ()) {
        
        let params = ["q": "'\(technology)' filter:images", "count": "2"]
        var clientError: NSError?
        let request = client.urlRequest(withMethod: "GET", url: statusesShowEndpoint, parameters: params, error: &clientError)
        
        client.sendTwitterRequest(request) { (response, data, connectionError) -> Void in
            if let connectionError = connectionError {
                print("Error: \(connectionError)")
                error(connectionError)
            }
            
            do {
                let dictionary = try JSONSerialization.jsonObject(with: data!, options: []) as! [String : Any?]
                success(dictionary)
               // print("json: \(dictionary)")
            } catch let jsonError as NSError {
                print("json error: \(jsonError.localizedDescription)")
                error(jsonError)
            }
        }        
    }
}