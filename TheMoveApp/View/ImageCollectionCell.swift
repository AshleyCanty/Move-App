//
//  ImageCollectionCell.swift
//  Move
//
//  Created by ashley canty on 8/7/19.
//  Copyright © 2019 ashley canty. All rights reserved.
//

import UIKit

class ImageCollectionCell: UICollectionViewCell {
    @IBOutlet weak var wrapper: ShadowView!
    @IBOutlet weak var imageView: UIImageView!
    override func awakeFromNib() {
//        wrapper.frame = bounds
//        wrapper.center = center
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        imageView.contentMode = .scaleAspectFill
    }
}
