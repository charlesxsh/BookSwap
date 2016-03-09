//
//  BookDetailViewController.swift
//  BookSwap
//
//  Created by Charles Xia on 1/22/16.
//  Copyright © 2016 Charles. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController {

    @IBOutlet weak var imgBookCover: UIImageView!
    @IBOutlet weak var lblBookName: UILabel!
    @IBOutlet weak var lblEdition: UILabel!
    @IBOutlet weak var lblAuthor: UILabel!
    
    @IBOutlet weak var btnBuy: UIButton!
    @IBOutlet weak var btnRent: UIButton!
    @IBOutlet weak var btnSwap: UIButton!
    @IBOutlet weak var btnPrice: UIButton!
    
    @IBOutlet weak var imgProfie: UIImageView!
    @IBOutlet weak var lblDisplayName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    
    var listObject:PFObject?
    var enableSell:Bool = false
    var enableRent:Bool = false
    var enableSwap:Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.btnPrice.hidden = true
        self.btnRent.hidden = true
        self.btnPrice.hidden = true
        self.btnSwap.hidden = true
        self.setBookName(self.listObject!["book"]["bookName"] as! String)
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
        self.setOwnerInformation(self.listObject!["BelongTo"] as! PFUser)
        if self.listObject!["sellPrice"] as! Float != -1{
            enableSell = true
        }
        
        if self.listObject!["rentPrice"] as! Float != -1{
            enableRent = true
        }
        
        enableSwap = self.listObject!["swap"] as! Bool
        
        if enableSell{
            self.btnBuy.enabled = true
            self.btnBuy.hidden = false
        }
        
        if enableRent{
            self.btnRent.enabled = true
            self.btnRent.hidden = false
        }
        
        if enableSwap{
            self.btnSwap.enabled = true
            self.btnSwap.hidden = false
        }
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
        self.lblAuthor.text = "Author(s):\(str)"
    }
    
    func setEdition(edition:Int){
        self.lblEdition.text = "Edition:\(edition)th"
    }
    
    func setOwnerInformation(user:PFUser){
        self.lblEmail.text = user["email"] as? String
        self.lblDisplayName.text = user["DisplayName"] as? String
        let imgFile = user["profie"] as! PFFile
        imgFile.getDataInBackgroundWithBlock { (img, error) -> Void in
            self.imgProfie.image = UIImage(data: img!)!
        }
    }
    
    @IBAction func btnBuyClicked(sender:UIButton){
        self.btnPrice.setTitle("Buy: $\(self.listObject!["sellPrice"] as! Float)", forState: .Normal)
        self.btnPrice.hidden = false
        self.btnPrice.enabled = true
        
    }
    
    @IBAction func btnRentClicked(sender:UIButton){
        self.btnPrice.setTitle("Rent: $\(self.listObject!["rentPrice"] as! Float)", forState: .Normal)
        self.btnPrice.hidden = false
        self.btnPrice.enabled = true

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch(segue.identifier!){
        case "showrequest":
            let dest = segue.destinationViewController as! MeRequestTableViewController
            dest.currentUser = self.listObject!["BelongTo"] as? PFUser
            
            break
        default:
            break;
        }
    }


}
