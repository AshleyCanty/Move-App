//
//  UserPostCell.swift
//  MoveApp
//
//  Created by ashley canty on 8/10/19.
//  Copyright © 2019 ashley canty. All rights reserved.
//

import UIKit

protocol UserPostDelegate: class {
    func removePost(index: IndexPath)
}

class UserPostCell: UICollectionViewCell, UserPostDelegate {
    
    
    @IBOutlet weak var contentWrapperView: UIView!
    @IBOutlet weak var topWrapperHeight: NSLayoutConstraint!
    @IBOutlet weak var bottomWrapperHeight: NSLayoutConstraint!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var editButtonHeight: NSLayoutConstraint!
    @IBOutlet weak var editButtonWidth: NSLayoutConstraint!
    
    weak var delegate: UserPostDelegate?
    var indexPath: IndexPath?
    var id: String?
    var post: SavedPost? {
        didSet {
            if let post = post {
                titleLabel.text = post.title
                imageView.image = UIImage(named: post.imgName)
                dateLabel.text = post.dateCreated
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        contentWrapperView.clipsToBounds = true
        contentWrapperView.layer.cornerRadius = 12
        
        if DeviceSize.iPhoneScreenSizes() == .iPad {
            topWrapperHeight.constant = 80
            bottomWrapperHeight.constant = 120
            dateLabel.font = dateLabel.font.withSize(25)
            titleLabel.font = titleLabel.font.withSize(30)
            editButtonHeight.constant = 65
            editButtonWidth.constant = 65
//            editButton.frame.size = CGSize(width: 45, height: 45)
        }
    }
    
    func removePost(index: IndexPath) {
        
    }
    
    @IBAction func editButtonDidTap() {
        guard let indexPath = indexPath else { return }
        delegate?.removePost(index: indexPath)
    }

}
