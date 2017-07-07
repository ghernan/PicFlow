//
//  TweetTime.swift
//  PicFlow
//
//  Created by Antonio  Hernandez  on 7/7/17.
//  Copyright © 2017 Antonio  Hernandez . All rights reserved.
//

import Foundation

enum TweetTimeType {
    
    case newer
    case older
    case none
    
    
    func getParameter() -> String {
        switch self {
        case .newer:
            return "since_id"
        case .older:
            return "max_id"
        default:
            return ""
        }
    }
}
