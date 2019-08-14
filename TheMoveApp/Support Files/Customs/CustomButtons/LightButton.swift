//
//  LightButton.swift
//  Move
//
//  Created by ashley canty on 8/5/19.
//  Copyright © 2019 ashley canty. All rights reserved.
//

import UIKit

//@IBDesignable
class LightButton: UIButton {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // Border:
        let borderGradientTop = UIColor.white.cgColor
        let borderGradientBottom = UIColor.white.cgColor
        let borderGradient = CAGradientLayer()
        borderGradient.frame = self.bounds
        borderGradient.colors = [borderGradientTop, borderGradientBottom]
        borderGradient.cornerRadius = 4
        
        let borderMask = CAShapeLayer()
        borderMask.lineWidth = 1
        borderMask.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: 4).cgPath
        borderMask.fillColor = UIColor.clear.cgColor
        borderMask.strokeColor = UIColor.black.cgColor
        
        borderGradient.mask = borderMask
        self.layer.insertSublayer(borderGradient, below: self.titleLabel?.layer)
        
        // Background:
        let backgroundGradientTop = UIColor.white.cgColor
        let backgroundGradientBottom = UIColor.white.cgColor
        let background = CAGradientLayer()
        background.frame = self.bounds
        background.colors = [backgroundGradientTop, backgroundGradientBottom]
        background.cornerRadius = 4
        self.layer.insertSublayer(background, below: borderGradient)
        
        // Shadow:
        self.layer.cornerRadius = 8.0
        self.layer.masksToBounds = false
        self.clipsToBounds = false
        self.layer.shadowColor = UIColor(white: 0, alpha: 0.5).cgColor
        self.layer.shadowOpacity = 0.4
        self.layer.shadowRadius = 12;
        self.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        
        // Text:
        self.setTitleColor(Colors.GreenMedium, for: .normal)
        self.setTitle(self.titleLabel?.text?.uppercased(), for: .normal)
        self.titleLabel?.font = UIFont.init(name: "HelveticaNeue-Medium", size: 17)
    }
}
