//
//  TextFieldDelegate.swift
//  Meme_v1.0
//
//  Created by Tom Zhang on 4/17/17.
//  Copyright © 2017 Tom Zhang. All rights reserved.
//

import Foundation
import UIKit

class TextFieldDelegate: NSObject, UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let oldText = textField.text! as NSString
        let newText = oldText.replacingCharacters(in: range, with: string) as NSString
        if newText.length > 20 {
            return false;
        } else {
            return true;
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        let oldText = textField.text
        if oldText == "TOP" || oldText == "BOTTOM"{
            textField.text = ""
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
}
