//
//  Colors.swift
//  Move
//
//  Created by ashley canty on 8/5/19.
//  Copyright © 2019 ashley canty. All rights reserved.
//

import UIKit


class Colors {
    static let GreenMedium = UIColor.getCustomColor(r: 184, g: 196, b: 128, a: 1)
    
    static let GreenLight = UIColor.getCustomColor(r: 212, g: 231, b: 158, a: 1)
    
    static let PinkDark = UIColor.getCustomColor(r: 146, g: 45, b: 80, a: 1)
    
    static let PurpleLight = UIColor.getCustomColor(r: 185, g: 72, b: 222, a: 1)
    
    static let PurpleDark2 = UIColor.getCustomColor(r: 124, g: 65, b: 155, a: 1)
    
    static let PurpleMedium = UIColor.getCustomColor(r: 80, g: 21, b: 55, a: 1)
    
    static let PurpleDark = UIColor.getCustomColor(r: 60, g: 27, b: 67, a: 1)
    
    static let IndigoLight = UIColor.getCustomColor(r: 88, g: 86, b: 214, a: 1)
    
    static let IndigoDark = UIColor.getCustomColor(r: 60, g: 59, b: 149, a: 1)
    
    static let textDarkColor = UIColor.getCustomColor(r: 89, g: 89, b: 89, a: 1)
}

extension UIColor {
    class func getCustomColor(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) -> UIColor {
        return UIColor(red: r/255, green: g/255, blue: b/255, alpha: a)
    }
}
