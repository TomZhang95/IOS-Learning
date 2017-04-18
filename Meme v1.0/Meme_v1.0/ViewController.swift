//
//  ViewController.swift
//  Meme_v1.0
//
//  Created by Tom Zhang on 4/17/17.
//  Copyright © 2017 Tom Zhang. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var imageShowing: UIImageView!
    
    let textFieldDelegate = TextFieldDelegate()
    let textFieldAttributes: [String:Any] = [
        NSForegroundColorAttributeName: UIColor.white,
        NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topTextField.delegate = textFieldDelegate
        topTextField.defaultTextAttributes = textFieldAttributes
        topTextField.textAlignment = .center
        bottomTextField.delegate = textFieldDelegate
        bottomTextField.defaultTextAttributes = textFieldAttributes
        bottomTextField.textAlignment = .center
    }

    @IBAction func pickFromCamra(_ sender: UIBarButtonItem) {
        let albumPicker = UIImagePickerController()
        albumPicker.delegate = self
        albumPicker.sourceType = .camera
        present(albumPicker, animated: true, completion: nil)
    }

    @IBAction func pickFromAlbum(_ sender: UIBarButtonItem) {
        let albumPicker = UIImagePickerController()
        albumPicker.delegate = self
        albumPicker.sourceType = .photoLibrary
        present(albumPicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageShowing.image = image
            dismiss(animated: true, completion: nil)
        } else {
            print("Could not find picture")
        }
    }


}

