//
//  BookRequestViewController.swift
//  BookSwap
//
//  Created by Charles Xia on 1/24/16.
//  Copyright © 2016 Charles. All rights reserved.
//

import UIKit
import Parse

class BookRequestViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var txfieldBookName: UITextField!
    @IBOutlet weak var txfieldBookEdition: UITextField!
    @IBOutlet weak var txfieldBookAuthor: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func makeRequest(sender: AnyObject) {
        let bookrequest = PFObject(className: "Request")
        bookrequest["BelongTo"] = PFUser.currentUser()!
        
        let book = PFObject(className: "Book")
        book["bookName"] = self.txfieldBookName.text!
        book["Author"] = self.txfieldBookAuthor.text!
        book["edition"] = Int(self.txfieldBookEdition.text!)
        book.saveInBackgroundWithBlock { (success, error) -> Void in
            if success{
                bookrequest["forBook"] = book
                bookrequest.saveInBackgroundWithBlock({ (success, error) -> Void in
                    if success{
                        self.navigationController?.popViewControllerAnimated(true)
                    }
                })
            }
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
         return true
    }
    
    @IBAction func hideKeyBoard(sender:AnyObject){
        self.view.endEditing(true)
    }
}
