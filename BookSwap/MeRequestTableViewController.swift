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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.registerNib(UINib(nibName: "TVCellForRequestBook", bundle: nil), forCellReuseIdentifier: "bookcell")
        //belongto equal currentUser
        BSReqlist.search("") { (error, dicts) -> Void in
            guard let dicts = dicts else {return}
            for dict in dicts {
                self.cellData.append(dict)
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
        cell.setBookName(cellData[indexPath.row]["BookName"] as! String)
        cell.setBookEdition(cellData[indexPath.row]["Edition"] as! Int)
        cell.setBookAuthor(cellData[indexPath.row]["Author"] as! String)
        return cell
    }

}
