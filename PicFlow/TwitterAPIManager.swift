//
//  TwitterAPI.swift
//  PicFlow
//
//  Created by Antonio  Hernandez  on 7/6/17.
//  Copyright © 2017 Antonio  Hernandez . All rights reserved.
//

import TwitterKit
import ObjectMapper

class TwitterAPIManager {
    
    
    static func getTweets(forMobileTechnology technology: TechnologyType, getTweetsOn time: TweetTimeType = .none, startingOnTweetID id: String = "", success: @escaping (_ tweets: [Tweet]) -> (), error: @escaping (_ error: Error) -> ()) {
            TwitterAPIService.requestTweets(forMobileTechnology: technology, getTweetsOn: time, startingOnTweetID: id,
                                            success: { dictionary in
                                                
                                                success(parseTweets(fromDictionary: dictionary))
                
            },
                                            error: {serviceError in
                                                error(serviceError)
            
            })    
    }

    static func getTweets(fromUser screenName: String, getTweetsOn time: TweetTimeType = .none, startingOnTweetID id: String = "", success: @escaping (_ tweets: [Tweet]) -> (), error: @escaping (_ error: Error) -> ()) {
        TwitterAPIService.requestUserTimeline(withUserName: screenName, getTweetsOn: time, startingOnTweetID: id,
                                        success: { dictionary in
                                            
                                            success(parseTimelineTweets(fromDictionary: dictionary))
                                            
        },
                                        error: {serviceError in
                                            error(serviceError)
                                            
        })    
    }

    private static func parseTweets(fromDictionary dictionary: [String : Any]) -> [Tweet] {
        
        guard let results = dictionary["statuses"] as? [[String : Any]] else {
            return []
        }
        let tweets = Mapper<Tweet>().mapArray(JSONArray: results)
        return tweets
    }
    
    private static func parseTimelineTweets(fromDictionary dictionaryArray: [[String : Any]]) -> [Tweet] {
        
        let tweets = Mapper<Tweet>().mapArray(JSONArray: dictionaryArray)
        
        return tweets
    }
    
}
