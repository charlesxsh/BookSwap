//
//  util.swift
//  BookSwap
//
//  Created by Charles Xia on 1/23/16.
//  Copyright © 2016 Charles. All rights reserved.
//

import UIKit
import Parse

extension PFObject{
static func createBook(name:String, author:String, edition:Int, coverImg:UIImage, block:PFBooleanResultBlock)->PFObject{
    let book = PFObject(className: "Book")
    book["bookName"] = name
    book["Author"] = author
    book["edition"] = edition
    book["coverImg"] = coverImg
    book.saveInBackgroundWithBlock(block)
    return book
}
}


extension PFUser{
    func postBook(book:PFObject, sPrice:Int, rPrice:Int, swap:Bool, block:PFBooleanResultBlock){
        let list = PFObject(className: "Listing")
        list["book"] = book
        list["sellPrice"] = sPrice
        list["rentPrice"] = rPrice
        list["swap"] = swap
        list["BelongTo"] = self
        list.saveInBackgroundWithBlock(block)
    }
    
    static func signCheck(vc:UIViewController){
        if PFUser.currentUser() == nil{
            let signInVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("Signin") as! SignInViewController
            vc.presentViewController(signInVC, animated: true, completion: nil)
        }
    }
}

extension UIImage{
    static func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage {
        
        let scale = newWidth / image.size.width
        let newHeight = image.size.height * scale
        UIGraphicsBeginImageContext(CGSizeMake(newWidth, newHeight))
        image.drawInRect(CGRectMake(0, 0, newWidth, newHeight))
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
}
