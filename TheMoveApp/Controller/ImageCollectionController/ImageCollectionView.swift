//
//  ImageListViewController.swift
//  Move
//
//  Created by ashley canty on 8/5/19.
//  Copyright © 2019 ashley canty. All rights reserved.
//

import UIKit

class ImageCollectionView: UICollectionViewController {
    
    
    let screenWidth = UIScreen.main.bounds.width
    let persistentManager = PersistentManager.shared
    
    var isEditingMode = false
    var rightButtonItem: UIBarButtonItem!
    var selectedIndex: IndexPath = [0,0]
    var dataTypeID: Int!
    var spinnerView = UIActivityIndicatorView(style: .gray)
    var savedPosts: [Posts] = [Posts]()
    var imgNames: [String]!
    var imgList: [UIImage] = [UIImage()] {
        didSet {
            refreshData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBarAppearance()
        loadDataType()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if dataTypeID == 2 {
            fetchSavedPosts()
            spinnerView.removeFromSuperview()
            view.layoutIfNeeded()
            view.layoutSubviews()
        }
        
        collectionView.reloadData()
    }
    
    func loadDataType() {
        if dataTypeID == 1 {
            collectionView.register(UINib.init(nibName: "ImageCollectionCell", bundle: .main), forCellWithReuseIdentifier: "imageCell")
            Images.loadImages { [weak self] (images, names) in
                guard let self = self else { return }
                self.imgList = images
                self.imgNames = names
            }
        } else {
            collectionView.register(UINib.init(nibName: "UserPostCell", bundle: .main), forCellWithReuseIdentifier: "userPost")
            collectionView.register(UINib.init(nibName: "EmptyPostsCollectionCell", bundle: .main), forCellWithReuseIdentifier: "emptyCell")
            
            // MARK: -- Access data from Core Data
            fetchSavedPosts()
        }
    }
    
    func fetchSavedPosts() {
        let savedPosts = persistentManager.fetch(Posts.self)
        self.savedPosts = savedPosts.reversed()
    }
    
    
    func setupViews() {
        if let view = view as? GradientView {
            view.startColor = Colors.IndigoLight
            view.endColor = Colors.IndigoLight
        }
        view.addSubview(spinnerView)
        spinnerView.center = collectionView.center
        spinnerView.startAnimating()
        createGradient()
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
        layout.itemSize = CGSize(width: screenWidth/3, height: screenWidth/3)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        collectionView.collectionViewLayout = layout
    }
    
    func createGradient() {
        let view = GradientView(frame: CGRect(x: 0, y: 0, width: collectionView.bounds.width, height: collectionView.bounds.height))
        view.bounds = collectionView.bounds
        if dataTypeID == 1 {
            view.startColor = Colors.IndigoLight
            view.endColor = Colors.IndigoDark
        } else {
            view.startColor = Colors.PurpleLight
            view.endColor = Colors.PurpleDark
        }
        collectionView.addSubview(view)
        collectionView.sendSubviewToBack(view)
        self.collectionView.backgroundView = view
    }
    
    func setBarAppearance() {
        if dataTypeID == 1 {
            setupBar("Images", barTintColor: Colors.IndigoDark, tintColor: .white, foregroundColor: UIColor.white, rightButtonItem: nil)
        } else {
            setupBar("My posts", barTintColor: Colors.PurpleDark2, tintColor: .white, foregroundColor: UIColor.white, rightButtonItem: nil)
        }
    }
}

// MARK: -- UICollectionView DataSource

extension ImageCollectionView: UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return getItemSize(with: indexPath)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return getItemCount()
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return getCellForItem(at: indexPath)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        itemSelected(at: indexPath)
    }
}


