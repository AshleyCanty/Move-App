//
//  ReadPostViewController.swift
//  MoveApp
//
//  Created by ashley canty on 8/11/19.
//  Copyright © 2019 ashley canty. All rights reserved.
//

import UIKit

class ReadPostViewController: UIViewController {
    
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    @IBOutlet weak var topImageHeight: NSLayoutConstraint!
    
    let persistentManager = PersistentManager.shared
    
    var id: String!
    var post: SavedPost?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createGradient()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setBarAppearance()
        if DeviceSize.iPhoneScreenSizes() == .iPad {
            dateLabel.font = dateLabel.font.withSize(25)
            titleLabel.font = titleLabel.font?.withSize(30)
            textView.font = textView.font?.withSize(25)
            topImageHeight.constant = (view.bounds.height/3 + 50)
        }
    }
    
    @IBAction func editPost(_ sender: Any) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "newPost") as? NewPostViewController {
            vc.existingPost = post
            // present as modal
            present(vc, animated: true, completion: nil)
        }
    }
    
    @IBAction func deletePost(_ sender: Any) {
        let alert = UIAlertController(title: "Are you sure you want to delete this post?", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { [weak self] (action) in
            guard let self = self else { return }
            self.deletePostFromCoreData() { [weak self] done in
                guard let self = self else { return }
                self.addUpdateView(withText: "Deleted!") { [weak self ] (done) in
                    guard let self = self else { return }
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: -- Delete from Core Data
    func deletePostFromCoreData(completion: @escaping ((Bool)->())) {
        let savedPosts = persistentManager.fetch(Posts.self)
        guard let post = post else { return }
        savedPosts.forEach { (savedPost) in
            if savedPost.id == post.id {
                persistentManager.delete(savedPost)
                completion(true)
            }
        }
    }
    
    func setupViews() {
        imageView.contentMode = .scaleAspectFill
        if let post = post {
            self.title = post.title
            titleLabel.text = post.title
            textView.text = post.text
            dateLabel.text = post.dateCreated
            imageView.image = UIImage(named: post.imgName)
            id = post.id
        }
    }
    
    func createGradient() {
        let gradientView = GradientView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: view.bounds.height))
            gradientView.bounds = view.bounds
            gradientView.startColor = Colors.PurpleLight
            gradientView.endColor = Colors.PurpleDark
        
        view.addSubview(gradientView)
        view.sendSubviewToBack(gradientView)
    }
    
    func setBarAppearance() {
        self.navigationController?.navigationBar.barTintColor = Colors.PurpleDark2
        self.navigationController?.navigationBar.tintColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
}
