//
//  DeviceSize.swift
//  Move
//
//  Created by ashley canty on 8/8/19.
//  Copyright © 2019 ashley canty. All rights reserved.
//

import UIKit

enum iPhones {
    case iPhone3_4
    case iPhone5
    case iPhone6
    case iPhone6Plus
    case iPad
    case not_an_iPhone
}

class DeviceSize {
    
    static func iPhoneScreenSizes() -> iPhones {
        let bounds = UIScreen.main.bounds
        let height = bounds.size.height
        
        switch height {
        case 480.0:
            print("iPhone 3,4")
            return .iPhone3_4
        case 568.0:
            print("iPhone 5")
            return .iPhone5
        case 667.0:
            print("iPhone 6")
            return .iPhone6
        case 736.0:
            print("iPhone 6+")
            return .iPhone6Plus
        case 1024...1366:
            print("iPad")
            return .iPad
        default:
            print("not an iPhone")
            return .not_an_iPhone
            
        }
    }
}
