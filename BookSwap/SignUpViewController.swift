//
//  SignUpViewController.swift
//  BookSwap
//
//  Created by Charles Xia on 1/23/16.
//  Copyright © 2016 Charles. All rights reserved.
//

import UIKit

protocol loginDelegate{
    func loginIn(usrname:String, passwd:String)
}

class SignUpViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var txfiedUsername: UITextField!
    @IBOutlet weak var txfiedDisplayName: UITextField!
    @IBOutlet weak var txfiedPassword: UITextField!
    
    @IBOutlet weak var imgProfie: UIImageView!
    var logindelegate:loginDelegate?
    let imgPickerController = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        imgPickerController.delegate = self
        imgPickerController.editing = false
        
        

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.imgProfie.layer.cornerRadius = self.imgProfie.frame.height/2
        self.imgProfie.clipsToBounds = true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func dismissVC(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print(segue.identifier)
    }
    
    @IBAction func signUpNewUser(sender: AnyObject) {
        let user = PFUser()
        user.username = txfiedUsername.text!
        user.email = txfiedUsername.text!
        user.password = txfiedPassword.text!
        user["DisplayName"] = txfiedDisplayName.text!
        let img = UIImage.resizeImage(self.imgProfie.image!, newWidth: 200)
        user["profie"] = PFFile(data: UIImagePNGRepresentation(img)!)
        user.signUpInBackgroundWithBlock { (success, error) -> Void in
            if success {
                self.logindelegate?.loginIn(user.username!, passwd: user.password!)
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }
    }
    
    @IBAction func hideKeyboard(sender: UIGestureRecognizer){
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    @IBAction func takePhoto(sender: UITapGestureRecognizer) {
        let alert = UIAlertController(title: "Choose from", message: nil, preferredStyle: .ActionSheet)
        alert.addAction(UIAlertAction(title: "Take Photo", style: .Default, handler: { (UIAlertAction) -> Void in
            alert.dismissViewControllerAnimated(true, completion:nil)
            self.imgPickerController.sourceType = .Camera
            self.presentViewController(self.imgPickerController, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Library", style: .Default, handler: { (UIAlertAction) -> Void in
            alert.dismissViewControllerAnimated(true, completion: nil)
            self.imgPickerController.sourceType = .PhotoLibrary
            self.presentViewController(self.imgPickerController, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .Cancel, handler: { (UIAlertAction) -> Void in
            alert.dismissViewControllerAnimated(true, completion: nil)
            
        }))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        if let img:UIImage? = image{
            self.imgProfie.contentMode = .ScaleToFill
            self.imgProfie.image = img
        }
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
}
