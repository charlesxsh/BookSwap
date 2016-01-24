//
//  BookDetailViewController.swift
//  BookSwap
//
//  Created by Charles Xia on 1/22/16.
//  Copyright © 2016 Charles. All rights reserved.
//

import UIKit
import Parse

class BookDetailViewController: UIViewController {

    @IBOutlet weak var imgBookCover: UIImageView!
    @IBOutlet weak var lblBookName: UILabel!
    @IBOutlet weak var lblEdition: UILabel!
    @IBOutlet weak var lblAuthor: UILabel!
    
    var listObject:PFObject?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setBookAuthor(self.listObject!["book"]["Author"] as! String)
        let imgFile = self.listObject!["book"]["coverImg"] as! PFFile
        if imgFile.dataAvailable{
            do{
                try self.setBookImg(UIImage(data: imgFile.getData())!)
            }catch{}
        }else{
            imgFile.getDataInBackgroundWithBlock { (img, error) -> Void in
                self.setBookImg(UIImage(data: img!)!)
            }
        }
        self.setEdition(self.listObject!["book"]["edition"] as! Int)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setListPFObject(obj:PFObject){
        self.listObject = obj
        
    }
    
    func setBookImg(img:UIImage){
        self.imgBookCover.image = img
    }
    
    func setBookName(str:String){
        self.lblBookName.text = str
    }
    
    func setBookAuthor(str:String){
        self.lblAuthor.text = str
    }
    
    func setEdition(edition:Int){
        self.lblEdition.text = "Edition:\(edition)th"
    }
    
    func setOwnerInformation(){
        
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
      
    }


}
