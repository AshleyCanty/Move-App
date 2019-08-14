//
//  Images.swift
//  Move
//
//  Created by ashley canty on 8/7/19.
//  Copyright © 2019 ashley canty. All rights reserved.
//

import UIKit

class Images {
    static func loadImages(completion: @escaping ([UIImage], [String]) -> ()) {
        DispatchQueue.global(qos: .background).async {
            let array = (1...16)
            var imgArray: [UIImage] = []
            var imgNames: [String] = []
            for i in array {
                let x = String(i)
                let image = UIImage(named: "\(x)") ?? UIImage()
                imgArray.append(image)
                imgNames.append(String(x))
            }
            completion(imgArray, imgNames)
        }
    }
}
