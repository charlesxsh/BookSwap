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
    
    
    @IBAction func takePhoto(sender: UITapGestureRecognizer) {
        self.presentViewController(imgPickerController, animated: true, completion: nil)
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
}
