//
//  NewPostViewController.swift
//  Move
//
//  Created by ashley canty on 8/6/19.
//  Copyright © 2019 ashley canty. All rights reserved.
//

import UIKit

class NewPostViewController: UIViewController {
    
    
    @IBOutlet weak var topShadowView: ShadowView!
    @IBOutlet weak var bottomShadowView: ShadowView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var topShadowHeight: NSLayoutConstraint!
    
    let defaultStory = "Share your story..."
    let defaultTitle = "Title goes here..."
    let viewtitle = "Create new post"
    let persistentManager = PersistentManager.shared
    
    var id: String!
    var imageName: String?
    var existingPost: SavedPost?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        checkForExistingPost()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setAppearance()
        
        if DeviceSize.iPhoneScreenSizes() == .iPad {
            dateLabel.font = dateLabel.font.withSize(25)
            titleField.font = titleField.font?.withSize(30)
            textView.font = textView.font?.withSize(25)
            topShadowHeight.constant = (view.bounds.height/3 + 50)
        }
        if DeviceSize.iPhoneScreenSizes() == .iPhone6 {
            topShadowHeight.constant = 200
        }
    }
    
    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        savePostToCoreData() { [weak self] done in
            guard let self = self else { return }
            
            var text = ""
            if self.existingPost == nil {
                text = "Published!"
            } else {
                text = "Saved!"
            }
            
            self.addUpdateView(withText: text) { [weak self] done in
                guard let self = self else { return }
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    func checkForExistingPost() {
        // check for existing post being edited
        if let post = existingPost {
            self.title = "Editing post"
            imageView.image = UIImage(named: post.imgName)
            titleField.text = post.title
            textView.text = post.text
            dateLabel.text = post.dateCreated
            id = post.id
        }
    }
    
    func savePostToCoreData(completion: @escaping ((Bool)->())) {
        if existingPost == nil {
            // save new post object to coredata
            let post = Posts(context: persistentManager.context)
            post.title = titleField.text
            post.text = textView.text
            post.date = dateLabel.text
            post.id = UUID().uuidString
            post.imgName = imageName
            persistentManager.saveContext()
            completion(true)
        } else {
            // find post object in coredata and modify
            guard let existingPost = existingPost else { return }
            let savedPosts = persistentManager.fetch(Posts.self)
            savedPosts.forEach { (savedpost) in
                if savedpost.id == existingPost.id {
                    savedpost.setValue(titleField.text, forKey: "title")
                    savedpost.setValue(textView.text, forKey: "text")
                    savedpost.setValue(dateLabel.text, forKey: "date")
                    persistentManager.saveContext()
                    completion(true)
                }
            }
        }
    }
    
    func setAppearance() {
        if let imageName = imageName { imageView.image = UIImage(named: imageName) }
        
        if let view = view as? GradientView {
            if existingPost == nil {
                saveButton.title = "Publish"
                setupBar("New post", barTintColor: Colors.IndigoDark, tintColor: .white, foregroundColor: UIColor.white, rightButtonItem: nil)
                view.startColor = Colors.IndigoLight
                view.endColor = Colors.IndigoDark
            } else {
                saveButton.title = "Save"
                setupBar("Edit post", barTintColor: Colors.PurpleDark2, tintColor: .white, foregroundColor: UIColor.white, rightButtonItem: nil)
                view.startColor = Colors.PurpleLight
                view.endColor = Colors.PurpleDark2
            }
        }
    }
    
    func setupViews() {
        if DeviceSize.iPhoneScreenSizes() == .iPhone5 {
            topShadowView.frame.size.height = (UIScreen.main.bounds.height*1/3)
        }
    
        if existingPost == nil { dateLabel.text = Date().getCurrentStringDate() }

        titleField.delegate = self
        titleField.text = defaultTitle
        textView.delegate = self
        textView.text = defaultStory
        textView.textColor = Colors.textDarkColor.withAlphaComponent(0.5)
        imageView.contentMode = .scaleAspectFill
    }
}

