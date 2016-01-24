//
//  BookUploadViewController.swift
//  BookSwap
//
//  Created by Charles Xia on 1/23/16.
//  Copyright © 2016 Charles. All rights reserved.
//

import UIKit

class BookUploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var ImageViewBook: UIImageView!
    @IBOutlet weak var TFBookName: UITextField!
    @IBOutlet weak var TFAuthor: UITextField!
    @IBOutlet weak var TFEdition: UITextField!
    @IBOutlet weak var btnSellPrice: UIButton!
    @IBOutlet weak var btnRentPrice: UIButton!
    
    var inputNumField: UITextField?
    let imgPickerController = UIImagePickerController()

    override func viewDidLoad() {
        super.viewDidLoad()
        imgPickerController.delegate = self
        imgPickerController.editing = false
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setSellPriceNum(price:Int){
        self.btnSellPrice.setTitle("Sell Price:\(price)", forState: .Normal)
    }
    
    func setRentPriceNum(price:Int){
        self.btnRentPrice.setTitle("Rent Price:\(price)", forState: .Normal)
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
    
    @IBAction func setSellPrice(sender: AnyObject) {
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
    }
    
    @IBAction func setRentPrice(sender: AnyObject) {
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

    }
}
