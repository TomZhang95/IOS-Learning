//
//  ViewController.swift
//  Meme_v1.0
//
//  Created by Tom Zhang on 4/17/17.
//  Copyright © 2017 Tom Zhang. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {


    @IBOutlet weak var topToolbar: UIToolbar!
    @IBOutlet weak var bottomToolbar: UIToolbar!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var imageShowing: UIImageView!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    let appDelegate = AppDelegate()
    let textFieldDelegate = TextFieldDelegate()
    let textFieldAttributes: [String:Any] = [
        NSForegroundColorAttributeName: UIColor.white,
        NSStrokeColorAttributeName: UIColor.black,
        NSFontAttributeName: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        subscribeKeyboardNotification()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        unsubscribeKeyboardNotification()
    }
    
    func configureTextField(_ textField: UITextField) {
        textField.delegate = textFieldDelegate
        textField.defaultTextAttributes = textFieldAttributes
        textField.textAlignment = .center
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTextField(topTextField)
        configureTextField(bottomTextField)
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func pickImage(_ type: UIImagePickerControllerSourceType) {
        let albumPicker = UIImagePickerController()
        albumPicker.delegate = self
        albumPicker.sourceType = type
        present(albumPicker, animated: true, completion: nil)
    }

    @IBAction func pickFromCamra(_ sender: UIBarButtonItem) {
        pickImage(.camera)
    }

    @IBAction func pickFromAlbum(_ sender: UIBarButtonItem) {
        pickImage(.photoLibrary)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageShowing.image = image
            imageShowing.contentMode = .scaleAspectFill
            dismiss(animated: true, completion: nil)
            shareButton.isEnabled = true
        } else {
            print("Could not find picture")
        }
    }
    
    func getKeyboardHeight(_ notification: Notification) ->CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    func keyboardWillShow(_ notification: Notification) {
        if bottomTextField.isFirstResponder {
            view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    func keyboardWillHide(_ notification: Notification) {
        if bottomTextField.isFirstResponder {
            view.frame.origin.y = 0
        }
    }

    func subscribeKeyboardNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: Notification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: Notification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeKeyboardNotification() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    func generateMemeImage() -> UIImage {
        bottomToolbar.isHidden = true
        topToolbar.isHidden = true
        
        UIGraphicsBeginImageContext(view.frame.size)
        view.drawHierarchy(in: view.frame, afterScreenUpdates: true)
        let memeImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        bottomToolbar.isHidden = false
        topToolbar.isHidden = false
        return memeImage
    }
    @IBAction func shareMemeImage(_ sender: UIBarButtonItem) {
        let sharingImage = generateMemeImage()
        let activityController = UIActivityViewController(activityItems: [sharingImage], applicationActivities: nil)
        present(activityController, animated: true, completion: nil)
        
        activityController.completionWithItemsHandler = {
            (acitivity, completed, returnedItems,error) in
            if completed {
                let meme = Meme(topText: self.topTextField.text!, bottomText: self.bottomTextField.text!, originalImage: self.imageShowing.image!, memedImage: sharingImage)
                self.appDelegate.memeObjects.append(meme)
                // store in app delegate
                print("Storing complet")
            }
            else {
                print("Storing not complet")
            }
        }
        
    }

}

