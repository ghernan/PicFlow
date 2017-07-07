//
//  TwitterAPIRouter.swift
//  PicFlow
//
//  Created by Antonio  Hernandez  on 7/7/17.
//  Copyright © 2017 Antonio  Hernandez . All rights reserved.
//

import Foundation

import Alamofire

enum TwitterAPIRouter: URLRequestConvertible {
    
    
    case getTweets(forTechnologyType: TechnologyType, getTweetsOn: TweetTimeType, startingOnTweetID: String )
    
    case getTimelineTweets(fromUser: String, getTweetsOn: TweetTimeType, startingOnTweetID: String)
    
    
    
    var query: (path: String, parameters: Parameters) {
        
        switch self {
            
        case .getTweets(let type, let time, let id):
                return ("search/tweets.json",["q" : "\(type.getHashTag()) filter:images", time.getParameter() : id, "count" : "20" ])
            
        case .getTimelineTweets(let user, let time, let id):
                return ("statuses/user_timeline.json",["screen_name" : user, time.getParameter() : id, "count" : "20" ])
            
        }
    }
    
    
    func asURLRequest() throws -> URLRequest {
        
        let url = try TwitterAPI.baseURL.asURL()
        let urlRequest = URLRequest(url: url.appendingPathComponent(query.path))
        return try URLEncoding.default.encode(urlRequest, with: query.parameters)
    }
}
