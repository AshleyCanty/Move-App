//
//  RoundImageView.swift
//  Move
//
//  Created by ashley canty on 8/6/19.
//  Copyright © 2019 ashley canty. All rights reserved.
//

import UIKit

@IBDesignable
class ShadowView: UIView {
  
    @IBInspectable var shadowRadius: CGFloat = 0 { didSet { layer.shadowRadius = shadowRadius } }
    @IBInspectable var shadowOpacity: Float = 0.0 { didSet { layer.shadowOpacity = shadowOpacity } }
    @IBInspectable var shadowColor: CGColor = UIColor.clear.cgColor { didSet { layer.shadowColor = shadowColor } }
    @IBInspectable var shadowOffset: CGSize = CGSize(width: 0, height: 0) { didSet { layer.shadowOffset =  shadowOffset } }
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.backgroundColor = .clear
        // if the shadow view contains a subview (another view or imageview), set it's frame to the subview's bounds
        
        if let subview = self.subviews.first {
            self.layer.shadowPath = UIBezierPath(roundedRect: subview.bounds, cornerRadius: 20).cgPath
        }
    }
}
