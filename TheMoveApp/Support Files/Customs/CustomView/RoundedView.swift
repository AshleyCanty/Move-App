//
//  RoundedView.swift
//  Move
//
//  Created by ashley canty on 8/6/19.
//  Copyright © 2019 ashley canty. All rights reserved.
//

import UIKit

//@IBDesignable
class RoundedView: UIView {
    
    @IBInspectable var radius: CGFloat = 0.0 { didSet { self.layer.cornerRadius = radius }}
    
    var setCorners: UIRectCorner!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.clipsToBounds = true
        roundCorners([.topLeft, .topRight], radius: radius)
    }
}
