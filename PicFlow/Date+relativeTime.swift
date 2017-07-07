//
//  Date+relativeTime.swift
//  PicFlow
//
//  Created by Antonio  Hernandez  on 7/7/17.
//  Copyright © 2017 Antonio  Hernandez . All rights reserved.
//

import ObjectMapper

extension Date{
    
    static func getRelativeTime(dateString: String) -> String {
        
        let formatter = DateFormatter()
        let now = Date()
        
        
        formatter.dateFormat = "EE MMM dd HH:mm:ss +0000 yyyy"
        formatter.timeZone = TimeZone(abbreviation:"GMT")
        guard let date = formatter.date(from: dateString) else {
            
            return ""
        }
        
        let nowSeconds = Int(now.timeIntervalSince1970)
        let dateSeconds = Int(date.timeIntervalSince1970)
        
        let inBetween = nowSeconds - dateSeconds
        formatter.dateFormat = "dd/MM/yy"
        
        switch true {
            
        case inBetween < 60:
            return "\(inBetween)s"
        case inBetween >= 60 && inBetween < 3600:
            return "\(inBetween/60)m"
        case inBetween >= 3600 && inBetween < 3600*24:
            return "\(inBetween/3600)h"
        case inBetween >= (3600*24) && inBetween < (3600*24*7):
            return "\(inBetween/(3600*24))d"
        default:
            return formatter.string(from: date)
        }
        
    }
    
    static let relativeTime = TransformOf<String, String>(fromJSON: { (dateString: String?) -> String? in
        return dateString != nil ? Date.getRelativeTime(dateString: dateString!) : nil
        
    }, toJSON: { (relativeTime: String?) -> String? in
        
        return relativeTime != nil ? relativeTime : nil
    })
}
