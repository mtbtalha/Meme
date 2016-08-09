//
//  MemeViewController.swift
//  Meme
//
//  Created by Talha Babar on 8/8/16.
//  Copyright © 2016 Talha Babar. All rights reserved.
//

import UIKit

class MemeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    //MARK: - IBOutlets
    
    @IBOutlet weak var imagView: UIImageView!
    @IBOutlet weak var cameraBarButton: UIBarButtonItem!
    @IBOutlet weak var topTextfield: UITextField!
    @IBOutlet weak var bottomTextfield: UITextField!
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    //MARK: - Variables
    
    let memeTextAttributes = [
        NSStrokeColorAttributeName : UIColor.blackColor(),
        NSForegroundColorAttributeName : UIColor.whiteColor(),
        NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName : -3.0
    ]
    
    //MARK: - View Lifecycle
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
        cameraBarButton.enabled = UIImagePickerController.isSourceTypeAvailable(.Camera)
        setupTextfield(topTextfield)
        setupTextfield(bottomTextfield)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        shareButton.enabled = false
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    //MARK: - IBActions
    
    @IBAction func pickPressed(sender: AnyObject) {
        setUpPickerForType(.PhotoLibrary)
    }

    @IBAction func cameraPressed(sender: AnyObject) {
        setUpPickerForType(.Camera)
    }
    
    @IBAction func sharePressed(sender: AnyObject) {
        if topTextfield.text == "" || topTextfield.text == "TOP" || bottomTextfield.text == "BOTTOM" || bottomTextfield.text == "" {
            let alert = UIAlertController(title: "Alert", message:"Are you sure you want to continue with this text?", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: { (action) in
                self.dismissViewControllerAnimated(true, completion: nil)
            }))
                
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: { (action) in
                self.showActivityController()
            }))
            presentViewController(alert, animated: true, completion: nil)
        } else {
            showActivityController()
        }
        
    }
    
    @IBAction func cancelNavButtonPressed(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    //MARK: - Utilities
    
    func showActivityController() {
        //Presenting ActivityController
        
        let memedImage = generateMemedImage()
        let topText = topTextfield.text
        let bottomText = bottomTextfield.text
        let activityController = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        activityController.completionWithItemsHandler = { (activityType: String?, completed: Bool, items: [AnyObject]?, error:NSError?) -> Void in
            
            if completed {
                let meme = Meme(topText: topText!, bottomText: bottomText!, originalImage: self.imagView.image!, memedImage: memedImage)
                (UIApplication.sharedApplication().delegate as! AppDelegate).memes.append(meme)
            }
        }
        
        presentViewController(activityController, animated: true, completion: nil)
    }
    
    func generateMemedImage() -> UIImage {
        toolbar.hidden = true
        navBar.hidden = true
        
        //Render view to an image
        UIGraphicsBeginImageContext(view.frame.size)
        view.drawViewHierarchyInRect(view.frame, afterScreenUpdates: true)
        let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        toolbar.hidden = false
        navBar.hidden = false
        return memedImage
    }
    
    
    func setUpPickerForType(sourceType: UIImagePickerControllerSourceType) {
        //Presenting UIImagePickerController
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = sourceType
        imagePicker.allowsEditing = true
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    func setupTextfield(textField: UITextField) {
        textField.defaultTextAttributes = memeTextAttributes
        textField.textAlignment = NSTextAlignment.Center
        textField.text = textField == topTextfield ? "TOP" : "BOTTOM"
        textField.delegate = self
    }
    
    //MARK: - UIImagePickerControllerDelegate
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        var image: UIImage?
        if let _ = info[UIImagePickerControllerEditedImage] as? UIImage {
            image = info[UIImagePickerControllerEditedImage] as? UIImage
        } else {
            image = info[UIImagePickerControllerOriginalImage] as? UIImage
        }
        
        imagView.image = image
        shareButton.enabled = true
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    //MARK: - UITextFieldDelegate
    
    func textFieldDidBeginEditing(textField: UITextField) {
        textField.text = ""
    }
    
    func textFieldDidEndEditing(textField: UITextField) {
        if textField == topTextfield {
            if textField.text == "" {
                topTextfield.text = "TOP"
            }
            
        } else {
            if textField.text == "" {
                bottomTextfield.text = "BOTTOM"
            }
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //MARK: - Keyboard Avoiding Methods
    
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MemeViewController.keyboardWillShow(_:))    , name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MemeViewController.keyboardWillHide(_:))    , name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name:
            UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name:
            UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        //if the first responder textfield is behind keyoard then move the view
        
        if topTextfield.isFirstResponder() && self.view.frame.origin.y + topTextfield.frame.origin.y >= 150 {
            UIView.animateWithDuration(0.3, animations: {
                self.view.frame.origin.y -= self.getKeyboardHeight(notification)
            })
        } else if bottomTextfield.isFirstResponder() && self.view.frame.origin.y + bottomTextfield.frame.origin.y >= 150 {
            UIView.animateWithDuration(0.3, animations: {
                self.view.frame.origin.y -= self.getKeyboardHeight(notification)
            })
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        //Replacing the view to its original state
        view.frame.origin.y = 0
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.CGRectValue().height
    }
}

