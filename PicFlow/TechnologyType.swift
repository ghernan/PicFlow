//
//  TechnologyType.swift
//  PicFlow
//
//  Created by Antonio  Hernandez  on 7/7/17.
//  Copyright © 2017 Antonio  Hernandez . All rights reserved.
//

import UIKit

enum TechnologyType: Int {
    
    case ios
    case android
    case windows
    
    func getHashTag() -> String {
        
        switch  self {
        case .android:
            return "#Android"
        case .ios:
            return "#iOS"
        case .windows:
            return "#Windows"
        }
    }
    
    func getLogo() -> UIImage {
        switch  self {
        case .android:
            return UIImage(named: "android")!
        case .ios:
            return UIImage(named: "apple")!
        case .windows:
            return UIImage(named: "windows")!
        }
    }
    
}
