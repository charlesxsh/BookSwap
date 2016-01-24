//
//  SignInViewController.swift
//  BookSwap
//
//  Created by Charles Xia on 1/23/16.
//  Copyright © 2016 Charles. All rights reserved.
//

import UIKit
import Parse

class SignInViewController: UIViewController, loginDelegate {

    
    @IBOutlet weak var txFieldUserName: UITextField!
    @IBOutlet weak var txFieldPassword: UITextField!
    
    
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
    
    func signIn(usrname:String, passwd:String){
        PFUser.logInWithUsernameInBackground(usrname, password: passwd) { (user, error) -> Void in
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    func loginIn(usrname: String, passwd: String) {
        signIn(usrname, passwd: passwd)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destVC = segue.destinationViewController as! SignUpViewController
        destVC.logindelegate = self
    }
    

}
