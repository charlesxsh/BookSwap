//
//  RootTabBarViewController.swift
//  BookSwap
//
//  Created by Charles Xia on 1/23/16.
//  Copyright © 2016 Charles. All rights reserved.
//

import UIKit

class RootTabBarViewController: UITabBarController, UITabBarControllerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tabBarController(tabBarController: UITabBarController, shouldSelectViewController viewController: UIViewController) -> Bool {
        if viewController.title == "Me"{
            if (!BSGlobal.isLogin()){
                let signInVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Signin") as! SignInViewController
                self.presentViewController(signInVC, animated: true, completion: nil)
                return false
            }
        }
        return true
    }
    

}
