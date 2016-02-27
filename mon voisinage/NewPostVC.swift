//
//  NewPostVC.swift
//  mon voisinage
//
//  Created by Kersuzan on 31/10/2015.
//  Copyright © 2015 Kersuzan. All rights reserved.
//

import UIKit

class NewPostVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var addPictureBtn: UIButton!
    @IBOutlet weak var pictureImg: UIImageView!
    @IBOutlet weak var titleTxtField: UITextField!
    @IBOutlet weak var descriptionTxtField: UITextField!
    
    var imagePickerController: UIImagePickerController!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.barStyle = UIBarStyle.Black

        
        self.title = "Write a new post"
        
        self.addPictureBtn.setTitle("Add picture", forState: UIControlState.Normal)
        
        self.pictureImg.layer.cornerRadius = self.pictureImg.frame.width / 2
        self.pictureImg.clipsToBounds = true
        
        self.titleTxtField.delegate = self
        self.descriptionTxtField.delegate = self
        self.imagePickerController = UIImagePickerController()
        self.imagePickerController.delegate = self
    }
    
    @IBAction func addPicturePressed(sender: UIButton!) {
        // Present an Action Sheet for choosing what kind of picture we want to add
        let actionSheet = UIAlertController(title: "Picture source", message: "Please choose your picture source", preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        let actionCamera = UIAlertAction(title: "Camera", style: UIAlertActionStyle.Default, handler: { (UIAlertAction) -> Void in
        
            self.imagePickerController.sourceType = UIImagePickerControllerSourceType.Camera
            self.presentViewController(self.imagePickerController, animated: true, completion: nil)
        })
        
        let actionLibrary = UIAlertAction(title: "Library", style: UIAlertActionStyle.Default, handler: { (UIAlertAction) -> Void in
            
            self.imagePickerController.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            self.presentViewController(self.imagePickerController, animated: true, completion: nil)
        })
        
        let actionCancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Destructive, handler: { (UIAlertAction) -> Void in
            self.addPictureBtn.setTitle("Add Picture", forState: UIControlState.Normal)
            self.dismissViewControllerAnimated(true, completion: nil)
        })

        actionSheet.addAction(actionCamera)
        actionSheet.addAction(actionLibrary)
        actionSheet.addAction(actionCancel)
        
        self.presentViewController(actionSheet, animated: true, completion: { () -> Void in
            print("finish")
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: "closeActionSheet:")
            self.view.addGestureRecognizer(tapGestureRecognizer)
        })
        
        self.addPictureBtn.setTitle("", forState: UIControlState.Normal)
        
        
    }
    
    @IBAction func createNewPostPressed(sender: UIButton!) {
        if let postImage = pictureImg.image, let title = titleTxtField.text where title != "", let description = descriptionTxtField.text where description != "" {
            let imagePath = DataService.instance.saveImageAndCreatePath(postImage)
            let newPost = Post(title: title, description: description, image: imagePath)
            DataService.instance.addPost(newPost)
            self.navigationController?.popViewControllerAnimated(true)
        } else {
            let alert = UIAlertController(title: "Cannot post!", message: "Please write a title and a description", preferredStyle: UIAlertControllerStyle.Alert)
            
            let action = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
            alert.addAction(action)
            self.presentViewController(alert, animated: true, completion: nil)
            
        }
    }
    
    func closeActionSheet(gestureRec: UIGestureRecognizer) {
        print("lol)")
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        

        self.pictureImg.image = image
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
    
    
}
