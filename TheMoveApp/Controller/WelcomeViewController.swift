//
//  ViewController.swift
//  Move
//
//  Created by ashley canty on 8/5/19.
//  Copyright © 2019 ashley canty. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    @IBOutlet weak var largeTextLabel: UILabel!
    @IBOutlet weak var smallTextLabel: UILabel!
    @IBOutlet var backgroundImage: UIImageView!
    @IBOutlet weak var swipeImageView: UIImageView!
    @IBOutlet weak var swipeTextLabel: UILabel!
    @IBOutlet weak var smallTextTrailing: NSLayoutConstraint!
    
    var circle: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        navigationController?.navigationBar.barStyle = .black
        animateImage()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setBarAppearance()
    }
    
    func setBarAppearance() {
        self.navigationController?.navigationBar.barTintColor = UIColor.black
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    func animateImage() {
        UIView.animate(withDuration: 0.7, delay: 0, options: [.repeat, .autoreverse], animations: { self.swipeImageView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }, completion: { finished in
            UIView.animate(withDuration: 0.7, animations: {
                self.swipeImageView.transform = CGAffineTransform(scaleX: 1, y: 1) })
        })
    }
    
    func setupViews(){
        smallTextLabel.setLineSpacing(lineSpacing: 1.0, lineHeightMultiple: 1.3)
        backgroundImage.image = UIImage(named: "homescreen")
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.addOpaqueLayer(color: Colors.PurpleMedium, opacity: 0.45, bounds: view.bounds)
        
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(UIViewController.swipeAction(swipe:)))
        leftSwipe.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(leftSwipe)
        
        if DeviceSize.iPhoneScreenSizes() == .iPad {
            largeTextLabel.font = largeTextLabel.font.withSize(80)
            smallTextLabel.font = smallTextLabel.font.withSize(30)
            swipeTextLabel.font = swipeTextLabel.font.withSize(30)
            swipeImageView.frame.size = CGSize(width: 65, height: 65)
            smallTextTrailing.constant = 200
        }
        
        if DeviceSize.iPhoneScreenSizes() == .iPhone6 {
            self.navigationController?.navigationBar.prefersLargeTitles = false
        }
    }
}

