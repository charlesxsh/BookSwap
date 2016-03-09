//
//  MeRequestTableViewController.swift
//  BookSwap
//
//  Created by Charles Xia on 1/24/16.
//  Copyright © 2016 Charles. All rights reserved.
//

import UIKit

class MeRequestTableViewController: UITableViewController {
    
    var cellData:[PFObject] = [PFObject]()
    var currentUser:PFUser?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.registerNib(UINib(nibName: "TVCellForRequestBook", bundle: nil), forCellReuseIdentifier: "bookcell")
        let query = PFQuery(className: "Request")
        query.whereKey("BelongTo", equalTo:currentUser!)
        query.includeKey("forBook")
        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
            if let objects = objects {
                for object in objects {
                    self.cellData.append(object)
                }
            }
            self.tableView.reloadData()
        }
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 50
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
        let cell = tableView.dequeueReusableCellWithIdentifier("bookcell", forIndexPath: indexPath) as! TVCellForRequestBook
        cell.setBookName(cellData[indexPath.row]["forBook"]["bookName"] as! String)
        cell.setBookEdition(cellData[indexPath.row]["forBook"]["edition"] as! Int)
        cell.setBookAuthor(cellData[indexPath.row]["forBook"]["Author"] as! String)
        return cell
    }

}
