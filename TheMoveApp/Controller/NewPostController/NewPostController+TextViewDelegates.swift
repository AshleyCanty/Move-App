//
//  NewPostController+TextViewDelegates.swift
//  MoveApp
//
//  Created by ashley canty on 8/12/19.
//  Copyright © 2019 ashley canty. All rights reserved.
//

import UIKit

extension NewPostViewController: UITextViewDelegate, UITextFieldDelegate {
    
    // MARK: -- TextViewDelegate
    
    func textViewDidChange(_ textView: UITextView) {
        textView.textColor = Colors.textDarkColor
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == defaultStory { textView.text = "" }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" { textView.text = defaultStory }
    }
    
    // MARK: -- TextFieldDelegate
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text == "" { textField.text = defaultTitle }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text == defaultTitle { textField.text = "" }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let count = textField.text?.count else { return false }
        if count > 35 {
            textField.text?.removeLast()
            return true
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}
