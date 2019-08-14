//
//  LightTextField.swift
//  Move
//
//  Created by ashley canty on 8/5/19.
//  Copyright © 2019 ashley canty. All rights reserved.
//

import UIKit

//@IBDesignable
class LightTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 30))
        leftView = paddingView
        leftViewMode = .always
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 0.7
        layer.backgroundColor = UIColor.white.cgColor
        layer.cornerRadius = 8
        font = UIFont.systemFont(ofSize: 17, weight: .regular)
        clipsToBounds = true
        
        backgroundColor = .white
        textColor = Colors.PurpleDark
    }
}
