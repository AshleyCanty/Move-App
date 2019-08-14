//
//  ImageCollection+DataTypeHandlers.swift
//  MoveApp
//
//  Created by ashley canty on 8/12/19.
//  Copyright © 2019 ashley canty. All rights reserved.
//

import UIKit

// MARK: -- DataType Handlers

extension ImageCollectionView {
    
    func refreshData(){
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.collectionView.reloadData()
            self.spinnerView.stopAnimating()
            self.spinnerView.removeFromSuperview()
        }
    }
    
    func animateCell(using cell: UICollectionViewCell, at indexPath: IndexPath) {
        cell.contentView.alpha = 0
        UIView.animate(
            withDuration: 0.5,
            delay: 0.03 * Double(indexPath.row),
            animations: {
                cell.contentView.alpha = 1
        })
    }
    
    func itemSelected(at indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        selectedIndex = indexPath
        
        if dataTypeID == 1 {
            if let vc = storyboard.instantiateViewController(withIdentifier: "newPost") as? NewPostViewController {
                if collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) is ImageCollectionCell {
                    vc.imageName = imgNames[indexPath.row]
                    navigationController?.pushViewController(vc, animated: true)
                }
            }
        } else if dataTypeID == 2 && savedPosts.count > 0 {
            // MARK: -- Pass Data to cell, present in readable view controller
            if let vc = storyboard.instantiateViewController(withIdentifier: "readPostVC") as? ReadPostViewController {
                if collectionView.dequeueReusableCell(withReuseIdentifier: "userPost", for: indexPath) is UserPostCell {
                    vc.post = convertPostObject(at: indexPath, using: savedPosts)
                    navigationController?.pushViewController(vc, animated: true)
                }
            }
        } else { print() }
    }
    
    func getItemCount() -> Int {
        if dataTypeID == 1 {
            if imgList.count > 1 {
                return imgList.count
            }
            return 0
        } else {
            if savedPosts.count > 0 {
                printSavedPosts()
                return savedPosts.count
            }
            return 1
        }
    }
    
    func getItemSize(with indexPath: IndexPath) -> CGSize{
        if dataTypeID == 1 {
            if DeviceSize.iPhoneScreenSizes() != .iPhone5 {
                if indexPath.row == 0 || indexPath.row == 8 {
                    return CGSize(width: screenWidth, height: screenWidth/2)
                } else if indexPath.row == 6 {
                    return CGSize(width: screenWidth/3, height: screenWidth/3)
                } else if indexPath.row == 7 {
                    return CGSize(width: (screenWidth * 2/3), height: screenWidth/3)
                } else if indexPath.row == 4 || indexPath.row == 5 || indexPath.row == 12 || indexPath.row == 13{
                    return CGSize(width: screenWidth/2, height: screenWidth/1.5)
                } else  if indexPath.row == 14 || indexPath.row == 15 {
                    return CGSize(width: screenWidth/2, height: screenWidth/2)
                } else {
                    return CGSize(width: screenWidth/3, height: screenWidth/3)
                }
            } else {
                return CGSize(width: screenWidth, height: screenWidth/2)
            }
        } else {
            if DeviceSize.iPhoneScreenSizes() == .iPad {
                return CGSize(width: screenWidth/2, height: screenWidth/2)
            }
            return CGSize(width: screenWidth, height: screenWidth)
        }
    }
    
    func getCellForItem(at indexPath: IndexPath) -> UICollectionViewCell {
        if dataTypeID == 1 {
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageCell", for: indexPath) as? ImageCollectionCell {
                animateCell(using: cell, at: indexPath)
                if imgList.count > 0 { cell.imageView.image = imgList[indexPath.row] }
                return cell
            }
        } else {
            if savedPosts.count > 0 {
                if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "userPost", for: indexPath) as? UserPostCell {
                    animateCell(using: cell, at: indexPath)
                    
                    // MARK: -- Pass data, images & title to cell
                    cell.post = convertPostObject(at: indexPath, using: savedPosts)
                    cell.editButton.addTarget(self, action: #selector(beginEditingPost), for: .touchUpInside)
                    cell.editButton.tag = indexPath.row
                    return cell
                }
            } else {
                if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "emptyCell", for: indexPath) as? EmptyPostsCollectionCell {
                    animateCell(using: cell, at: indexPath)
                    return cell
                }
            }
        }
        return UICollectionViewCell()
    }
    
    @objc func editCollection() {
        print("edit Collection")
    }
    
    @objc func beginEditingPost(_ sender: UIButton){
        let indexPath = IndexPath(item: sender.tag, section: 0)
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "newPost") as? NewPostViewController {
            vc.existingPost = convertPostObject(at: indexPath, using: savedPosts)
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func printSavedPosts() {
        savedPosts.forEach { (post) in
            print(post.title ?? "", post.id ?? "")
        }
    }
}
