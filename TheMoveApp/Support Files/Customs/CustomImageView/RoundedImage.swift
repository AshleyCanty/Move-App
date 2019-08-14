//
//  RoundedImage.swift
//  Move
//
//  Created by ashley canty on 8/6/19.
//  Copyright © 2019 ashley canty. All rights reserved.
//

import UIKit

//@IBDesignable
class RoundedImageView: UIImageView {
    override func layoutSubviews() {
        super.layoutSubviews()
        self.clipsToBounds = true
        self.layer.cornerRadius = 20
    }
}
