//
//  BooksTableViewController.swift
//  BookSwap
//
//  Created by Charles Xia on 1/22/16.
//  Copyright © 2016 Charles. All rights reserved.
//

import UIKit

class BooksTableViewController: UITableViewController, UISearchResultsUpdating {
    
    var selectedIndex:NSIndexPath?
    var resultSearchController:UISearchController!
//    var filteredTableData = []()
    var cellData:[BSOnlist] = [BSOnlist]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.registerNib(UINib(nibName: "TVCellForBooks", bundle: nil), forCellReuseIdentifier: "bookcell")

        self.resultSearchController = ({
            let controller = UISearchController(searchResultsController: nil)
            controller.searchResultsUpdater = self
            controller.dimsBackgroundDuringPresentation = true
            controller.searchBar.sizeToFit()
            self.tableView.tableHeaderView = controller.searchBar
            
            return controller
        })()
        
//        let query = PFQuery(className: "Listing")
//        query.includeKey("book")
//        query.includeKey("BelongTo")
//        query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
//            if let objects = objects{
//                for object in objects{
//                    self.cellData.append(object)
//                }
//            }
//            self.tableView.reloadData()
//        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellData.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 132
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:TVCellForBooks = tableView.dequeueReusableCellWithIdentifier("bookcell", forIndexPath: indexPath) as! TVCellForBooks
//        if (self.resultSearchController.active) {
//            cell.textLabel?.text = filteredTableData[indexPath.row]
//            
//            return cell
//        }
        cell.setbookNameForCell(cellData[indexPath.row]["book"]["bookName"] as! String)
        cell.setbookOwnerForCell(cellData[indexPath.row]["BelongTo"]["DisplayName"] as! String)
        cell.setBookedition(cellData[indexPath.row]["book"]["edition"] as! Int)
        let imgFile = cellData[indexPath.row]["book"]["coverImg"] as! PFFile
        if imgFile.dataAvailable{
            do{
                try cell.setBookImageForCell(UIImage(data: imgFile.getData())!)
            }catch{
                
            }
        }else{
            imgFile.getDataInBackgroundWithBlock { (img, error) -> Void in
            cell.setBookImageForCell(UIImage(data: img!)!)
            }
        }
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "segShowBookDetail"{
            let des:BookDetailViewController = segue.destinationViewController as! BookDetailViewController
            des.setListPFObject(self.cellData[self.selectedIndex!.row])
        }
        
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.selectedIndex = indexPath
        self.performSegueWithIdentifier("segShowBookDetail", sender: self)
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
//        filteredTableData.removeAll(keepCapacity: false)
//        
//        let searchPredicate = NSPredicate(format: "SELF CONTAINS[c] %@", searchController.searchBar.text)
//        let array = (tableData as NSArray).filteredArrayUsingPredicate(searchPredicate)
//        filteredTableData = array as! [String]
//        
//        self.tableView.reloadData()
    }

}
