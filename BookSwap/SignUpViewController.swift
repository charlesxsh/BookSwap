//
//  SignUpViewController.swift
//  BookSwap
//
//  Created by Charles Xia on 1/23/16.
//  Copyright © 2016 Charles. All rights reserved.
//

import UIKit
import Parse

protocol loginDelegate{
    func loginIn(usrname:String, passwd:String)
}

class SignUpViewController: UIViewController {

    @IBOutlet weak var txfiedUsername: UITextField!
    @IBOutlet weak var txfiedDisplayName: UITextField!
    @IBOutlet weak var txfiedPassword: UITextField!
    
    var logindelegate:loginDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
        user.signUpInBackgroundWithBlock { (success, error) -> Void in
            if success {
                self.logindelegate?.loginIn(user.username!, passwd: user.password!)
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }
    }
}
