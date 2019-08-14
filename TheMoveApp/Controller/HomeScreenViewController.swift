//
//  HomeScreenViewController.swift
//  MoveApp
//
//  Created by ashley canty on 8/10/19.
//  Copyright © 2019 ashley canty. All rights reserved.
//

import UIKit

class HomescreenViewContoller: UIViewController {
    
    
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var shadowView: ShadowView!
    @IBOutlet weak var shadowViewHeight: NSLayoutConstraint!
    @IBOutlet weak var qouteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var countTitleLabel: UILabel!
    @IBOutlet weak var postCountLabel: UILabel!
    @IBOutlet weak var viewPostsButton: UIButton!
    @IBOutlet weak var createPostButton: UIButton!
    
    @IBOutlet weak var innerViewLeading: NSLayoutConstraint!
    @IBOutlet weak var innerViewTrailing: NSLayoutConstraint!
    @IBOutlet weak var imageTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var authorTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var stackBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var viewButtonHeight: NSLayoutConstraint!
    @IBOutlet weak var createButtonHeight: NSLayoutConstraint!
    
    
    
    var author: String = "" {
        didSet {
            authorLabel.text = author
        }
    }
    
    var qoute: String = "" {
        didSet {
            qouteLabel.text = qoute
            adjustHeight()
            fadeText()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setBarAppearance()
        generateData()
        setupViews()
    }
    
    @IBAction func viewPostsDidTap(_ sender: UIButton) {
        performSegue(withIdentifier: "userPosts", sender: self)
    }
    
    @IBAction func createPostDidTap() {
        performSegue(withIdentifier: "imageList", sender: self)
    }
    
    func generateData() {
        let qouteData = Qoutes().randomQoute
        author = qouteData.author
        qoute = qouteData.qoute
        
        let savedPosts = PersistentManager.shared.fetch(Posts.self)
        let count = savedPosts.count
        postCountLabel.text = String(count)
    }
    
    func setBarAppearance() {
        self.navigationController?.navigationBar.barTintColor = .black
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
    
    func fadeText() {
        self.qouteLabel.layer.opacity = 0
        self.authorLabel.layer.opacity = 0
        UIView.animate(withDuration: 0.7, delay: 0, options: .curveEaseInOut, animations: {
            self.qouteLabel.layer.opacity = 1
            self.authorLabel.layer.opacity = 1
        })
    }
    
    func adjustHeight() {
        view.layoutIfNeeded()
        let height = qouteLabel.bounds.height + authorLabel.bounds.height
        let newHeight = (16+20+12+22+12+20+120+16+height)
        shadowViewHeight.constant = newHeight
        setupViews()
        
        self.view.layoutIfNeeded()
        self.view.layoutSubviews()
        
    }
    
    func setupViews() {
        if DeviceSize.iPhoneScreenSizes() == .iPad {
            print("changing")
            let shadowHeight = shadowView.bounds.height
            shadowViewHeight.constant = (shadowHeight + 50)
            
            viewPostsButton.titleLabel?.font = UIFont(name: "HelveticaNeue-medium", size: 30)
            createPostButton.titleLabel?.font = UIFont(name: "HelveticaNeue-medium", size: 30)
            
            qouteLabel.font = qouteLabel.font.withSize(30)
            authorLabel.font = authorLabel.font.withSize(30)
            countTitleLabel.font = countTitleLabel.font.withSize(30)
            postCountLabel.font = postCountLabel.font.withSize(30)
            
            iconImage.frame = CGRect(x: 0, y: 0, width: 180, height: 180)
            
            innerViewLeading.constant = 40
            innerViewTrailing.constant = 40
            authorTopConstraint.constant = 30
            viewButtonHeight.constant = 120
            createButtonHeight.constant = 120
            stackBottomConstraint.constant = 25
            imageTopConstraint.constant = 25
            
            viewPostsButton.imageEdgeInsets.right = 20
            createPostButton.imageEdgeInsets.right = 20
        }
    }
    
    // MARK: -- UINavigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let identifier = segue.identifier
        if let vc = segue.destination as? ImageCollectionView {
            if identifier == "imageList" {
                // send 1
                vc.dataTypeID = 1
            } else if identifier == "userPosts" {
                // send 2
                vc.dataTypeID = 2
            }
        }
    }
}


