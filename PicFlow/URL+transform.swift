//
//  String+toURL.swift
//  PicFlow
//
//  Created by Antonio  Hernandez  on 7/2/17.
//  Copyright © 2017 Antonio  Hernandez . All rights reserved.
//

import ObjectMapper

extension URL {
    
    static let transform = TransformOf<URL, String>(fromJSON: { (urlString: String?) -> URL? in
        
        return urlString != nil ? URL(string: urlString!) : nil
        
    }, toJSON: { (url: URL?) -> String? in
        
        return url != nil ? url!.absoluteString : nil
    })
    
}
