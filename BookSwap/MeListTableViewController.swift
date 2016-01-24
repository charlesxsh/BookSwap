//
//  MeListTableViewController.swift
//  BookSwap
//
//  Created by Charles Xia on 1/24/16.
//  Copyright © 2016 Charles. All rights reserved.
//

import UIKit
import Parse
class MeListTableViewController: UITableViewController {
    
    var cellData:[PFObject] = [PFObject]()
    let currentUser:PFUser = PFUser.currentUser()!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.registerNib(UINib(nibName: "TVCellForBooks", bundle: nil), forCellReuseIdentifier: "bookcell")
        let query = PFQuery(className: "Listing")
        query.whereKey("BelongTo", equalTo:currentUser)
        query.includeKey("book")
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if let objects = objects {
                for object in objects {
                    self.cellData.append(object)
                }
            }
            self.tableView.reloadData()
        }
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellData.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("bookcell", forIndexPath: indexPath) as! TVCellForBooks
        cell.setbookNameForCell(cellData[indexPath.row]["book"]["bookName"] as! String)
        cell.setbookOwnerForCell("Myself")
        let imgFile = cellData[indexPath.row]["book"]["coverImg"] as! PFFile
        imgFile.getDataInBackgroundWithBlock { (img, error) -> Void in
            cell.setBookImageForCell(UIImage(data: img!)!)
        }
        
        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 132
    }

}
