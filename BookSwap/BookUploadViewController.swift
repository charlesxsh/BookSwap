//
//  BookUploadViewController.swift
//  BookSwap
//
//  Created by Charles Xia on 1/23/16.
//  Copyright © 2016 Charles. All rights reserved.
//

import UIKit
import Parse

class BookUploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var ImageViewBook: UIImageView!
    @IBOutlet weak var TFBookName: UITextField!
    @IBOutlet weak var TFAuthor: UITextField!
    @IBOutlet weak var TFEdition: UITextField!
    @IBOutlet weak var btnSellPrice: UIButton!
    @IBOutlet weak var btnRentPrice: UIButton!
    @IBOutlet weak var btnSwap: UIButton!
    
    var inputNumField: UITextField?
    let imgPickerController = UIImagePickerController()
    
    var sPrice:Int?
    var rPrice:Int?
    var isSwap:Bool?
    override func viewDidLoad() {
        super.viewDidLoad()
        imgPickerController.delegate = self
        imgPickerController.editing = false
        self.btnSellPrice.setTitle("Enable Selling", forState: .Normal)
        self.btnRentPrice.setTitle("Enable Renting", forState:  .Normal)
        self.btnSwap.setTitle("Enable Swap", forState:  .Normal)
        self.btnSwap.setTitleColor(UIColor.grayColor(), forState: .Normal)
        self.btnRentPrice.setTitleColor(UIColor.grayColor(), forState: .Normal)
        self.btnSellPrice.setTitleColor(UIColor.grayColor(), forState: .Normal)

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setSellPriceNum(price:Int){
        self.btnSellPrice.setTitle("Sell Price:\(price)", forState: .Normal)
        self.sPrice = price
    }
    
    func setRentPriceNum(price:Int){
        self.btnRentPrice.setTitle("Rent Price:\(price)", forState: .Normal)
        self.rPrice = price
    }
    
    @IBAction func hideKeyboard(sender: UIGestureRecognizer){
        self.view.endEditing(true)
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
            ImageViewBook.contentMode = .ScaleAspectFit
            ImageViewBook.image = img
        }
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func setSellPrice(sender: UIButton) {
        switch(sender.tag){
        case 1: //gray
            sender.setTitleColor(UIColor.blueColor(), forState: .Normal)
            let inputText = UIAlertController(title: "Enter definition", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
            inputText.addTextFieldWithConfigurationHandler { (tf) -> Void in
                tf.placeholder = "price:"
                self.inputNumField = tf
            }
            inputText.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: nil))
            inputText.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (UIAlertAction) -> Void in
                self.setSellPriceNum(Int(self.inputNumField!.text!)!)
            }))
            self.presentViewController(inputText, animated: true, completion: nil)
            sender.tag = 2
            break;
        case 2: //blue
            sender.setTitleColor(UIColor.grayColor(), forState: .Normal)
            sender.setTitle("Enable Selling", forState: .Normal)
            sender.tag = 1
            break;
        default:
            break;
        }
        
    }
    
    @IBAction func setRentPrice(sender: UIButton) {
        switch(sender.tag){
        case 1:
            sender.tag = 2
            sender.setTitleColor(UIColor.blueColor(), forState: .Normal)
            let inputText = UIAlertController(title: "Enter definition", message: nil, preferredStyle: UIAlertControllerStyle.Alert)
            inputText.addTextFieldWithConfigurationHandler { (tf) -> Void in
                tf.placeholder = "price:"
                self.inputNumField = tf
            }
            inputText.addAction(UIAlertAction(title: "Cancel", style: .Default, handler: nil))
            inputText.addAction(UIAlertAction(title: "OK", style: .Default, handler: { (UIAlertAction) -> Void in
                self.setRentPriceNum(Int(self.inputNumField!.text!)!)
                
            }))
            self.presentViewController(inputText, animated: true, completion: nil)
            break;
        case 2:
            sender.tag = 1
            sender.setTitleColor(UIColor.grayColor(), forState: .Normal)
            sender.setTitle("Enable Renting", forState: .Normal)
            break;
        default:
            break;
        }



    }
    
    @IBAction func setSwap(sender: UIButton){
        switch(sender.tag){
        case 1: //gray
            sender.tag = 2
            sender.setTitleColor(UIColor.blueColor(), forState: .Normal)
            sender.setTitle("Disable Swap", forState: .Normal)
            self.isSwap = false
            break;
        case 2: //blue
            sender.tag = 1
            sender.setTitleColor(UIColor.grayColor(), forState: .Normal)
            sender.setTitle("Enable Swap", forState: .Normal)
            self.isSwap = true
            break;
        default:
            break;
        }
    }
    
    @IBAction func postABook(sender: AnyObject) {
        PFUser.signCheck(self)
        let book = PFObject(className: "Book")
        book["bookName"] = self.TFBookName.text!
        book["Author"] = self.TFAuthor.text!
        book["edition"] = Int(self.TFEdition.text!)
        let afterScareImg = UIImage.resizeImage(self.ImageViewBook.image!, newWidth: 600)
        book["coverImg"] = PFFile(data: UIImagePNGRepresentation(afterScareImg)!)
        
        let post = PFObject(className: "Listing")
        if self.sPrice != -1{
            post["sellPrice"] = self.sPrice
        }
        
        if self.rPrice != -1{
            post["rentPrice"] = self.rPrice
        }
        
        post["swap"] = self.isSwap
        
        post["BelongTo"] = PFUser.currentUser()!
        book.saveInBackgroundWithBlock { (success, error) -> Void in
            if success{
                post["book"] = book
                post.saveInBackgroundWithBlock({ (success, error) -> Void in
                    print("success")
                })
            }else{
                print(error)
            }
        }
        
       
    }
}
