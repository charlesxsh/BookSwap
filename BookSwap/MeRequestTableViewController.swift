//
//  MeRequestTableViewController.swift
//  BookSwap
//
//  Created by Charles Xia on 1/24/16.
//  Copyright © 2016 Charles. All rights reserved.
//

import UIKit

class MeRequestTableViewController: UITableViewController {
    
    var cellData:[BSObject] = [BSObject]()
    var currentUser:BSUser?
    let query = BSQuery(collectionName: "RequestList")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.registerNib(UINib(nibName: "TVCellForRequestBook", bundle: nil), forCellReuseIdentifier: "bookcell")
        self.refreshControl?.addTarget(self, action: "refreshing:", forControlEvents: UIControlEvents.ValueChanged)
        //belongto equal currentUser
        query.whereKey("belongTo", equalTo: self.currentUser!.objectId!)
        query.query { (error, objects) -> Void in
            guard error == nil else {
                debugPrint(error)
                return
            }
            guard let objects = objects else {return}
            for object in objects {
                self.cellData.append(object)
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
        let tempReq:BSObject = cellData[indexPath.row]
        cell.setBookName(tempReq["bookName"] as! String)
        cell.setBookEdition(tempReq["edition"] as! Int)
        cell.setBookAuthor(tempReq["authorName"] as! String)
        return cell
    }
    
    func refreshing(sender:AnyObject)
    {
        self.cellData.removeAll(keepCapacity: true)
        query.query { (error, objects) -> Void in
            guard error == nil else {
                debugPrint(error)
                return
            }
            guard let objects = objects else {return}
            for object in objects {
                self.cellData.append(object)
            }
            self.tableView.reloadData()
        }
        self.refreshControl?.endRefreshing()
        // Code to refresh table view
    }

}
