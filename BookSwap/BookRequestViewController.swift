//
//  BookRequestViewController.swift
//  BookSwap
//
//  Created by Charles Xia on 1/24/16.
//  Copyright © 2016 Charles. All rights reserved.
//

import UIKit

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
        let bookrequest = BSReqlist()
        bookrequest.belongTo = BSGlobal.currentUser!
        bookrequest.bookName = self.txfieldBookName.text!
        bookrequest.authorName = self.txfieldBookAuthor.text!
        let edition = Int(self.txfieldBookEdition.text!)
        guard edition != nil else {
            debugPrint("Incorrect edition information")
            return
        }
        bookrequest.edition = edition
        bookrequest.upLoad { (error) -> Void in
            guard error == nil else {
                debugPrint(error)
                return
            }
            
            dispatch_async(dispatch_get_main_queue()){
                self.navigationController?.popViewControllerAnimated(true)
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
