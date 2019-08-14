//
//  Extensions.swift
//  Move
//
//  Created by ashley canty on 8/5/19.
//  Copyright © 2019 ashley canty. All rights reserved.
//

import UIKit


// MARK: -- Date

extension Date {
    func getCurrentStringDate() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd yyyy"
        
        let result = formatter.string(from: date)
        return result
    }
}


// MARK: -- UIViewController

extension UIViewController {
    
    func addUpdateView(withText text: String, completion: @escaping ((Bool)->())) {
        let outerView = ShadowView(frame: CGRect(x: 0, y: 0, width: 100, height: 50))
        outerView.layer.shadowOpacity = 0.3
        outerView.layer.shadowRadius = 5
        outerView.layer.shadowOffset = CGSize(width: 0, height: 0)
        
        let innerView = UIView(frame: CGRect(x: 0, y: 0, width: outerView.bounds.width, height: outerView.bounds.height))
        innerView.clipsToBounds = true
        innerView.layer.cornerRadius = 12

        switch text {
        case "Published!":
            innerView.backgroundColor = Colors.IndigoLight
        case "Saved!":
            innerView.backgroundColor = Colors.PurpleDark2
        case "Deleted!":
            innerView.backgroundColor = Colors.PurpleDark2
        default:
            print()
        }
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: outerView.bounds.width, height: outerView.bounds.height))
        label.text = text
        label.font = UIFont.init(name: "HelveticaNeue-Bold", size: 17)
        label.textColor = .white
        label.textAlignment = .center
        
        innerView.addSubview(label)
        outerView.addSubview(innerView)
        view.addSubview(outerView)
        
        label.center = outerView.center
        outerView.center = view.center
        
        UIView.animate(withDuration: 1, delay: 0.3, options: .curveEaseInOut, animations: {
            outerView.layer.opacity = 0
        }) { (finished) in
            outerView.removeFromSuperview()
            completion(true)
        }
    }
    
    func convertPostObject(at indexPath: IndexPath, using savedPosts: [Posts]) -> SavedPost {
        let post = savedPosts[indexPath.row]
        let title = post.title ?? ""
        let text = post.text ?? ""
        let dateCreated = post.date ?? ""
        let imgName = post.imgName ?? ""
        let id = post.id ?? ""
        let postObject = SavedPost(title: title, text: text, dateCreated: dateCreated, id: id, imgName: imgName)
        return postObject
    }
    
    func setupBar(_ title: String, barTintColor: UIColor, tintColor: UIColor, foregroundColor: UIColor, rightButtonItem: UIBarButtonItem?){
        self.title = title
        self.navigationController?.navigationBar.barTintColor = barTintColor
        self.navigationController?.navigationBar.tintColor = tintColor
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: foregroundColor]
        if rightButtonItem != nil {
            self.navigationItem.rightBarButtonItem = rightButtonItem
        }
    }
    
    @objc func swipeAction(swipe: UISwipeGestureRecognizer) {
        switch swipe.direction {
        case UISwipeGestureRecognizer.Direction.left:
        performSegue(withIdentifier: "pushToHome", sender: nil)
        default:
            break
        }
    }
    
    func callModal(vc: UIViewController, presentationStyle: UIModalPresentationStyle) {
        vc.modalPresentationStyle = presentationStyle
        present(vc, animated: false, completion: nil)
    }
}


// MARK: -- UIView

extension UIView {
    func addOpaqueLayer(color: UIColor, opacity: Float, bounds: CGRect) {
        let view = UIView()
        view.frame = bounds
        view.layer.opacity = opacity
        view.backgroundColor = color
        
        let gradientView = GradientView()
        gradientView.startColor = UIColor.clear
        gradientView.endColor = .black
        gradientView.frame = view.bounds
        
        view.addSubview(gradientView)
        self.addSubview(view)
    }
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        if #available(iOS 11.0, *) {
            clipsToBounds = true
            layer.cornerRadius = radius
            layer.maskedCorners = CACornerMask(rawValue: corners.rawValue)
        } else {
            let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            layer.mask = mask
        }
    }
}


// MARK: -- UILabel

extension UILabel {
    
    // Pass value for any one of both parameters and see result
    func setLineSpacing(lineSpacing: CGFloat = 0.0, lineHeightMultiple: CGFloat = 0.0) {
        
        guard let labelText = self.text else { return }
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = lineSpacing
        paragraphStyle.lineHeightMultiple = lineHeightMultiple
        
        let attributedString:NSMutableAttributedString
        if let labelattributedText = self.attributedText {
            attributedString = NSMutableAttributedString(attributedString: labelattributedText)
        } else {
            attributedString = NSMutableAttributedString(string: labelText)
        }
        
        // Line spacing attribute
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        
        self.attributedText = attributedString
    }
    
    func halfTextColorChange (fullText : String , changeText : String ) {
        let strNumber: NSString = fullText as NSString
        let range = (strNumber).range(of: changeText)
        let attribute = NSMutableAttributedString.init(string: fullText)
        attribute.addAttribute(NSAttributedString.Key.foregroundColor, value: Colors.GreenLight , range: range)
        self.attributedText = attribute
    }
}
