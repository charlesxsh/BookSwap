//
//  MeTableViewController.swift
//  BookSwap
//
//  Created by Charles Xia on 1/23/16.
//  Copyright © 2016 Charles. All rights reserved.
//

import UIKit
import Parse

class MeTableViewController: UITableViewController {
    
    let Data:[Int:[String]] = [0:["Me","Email"], 1:["My Request", "My Listing"], 2:["Log out"]]
    var currentUser:PFUser?
    
    override func viewDidLoad() {
        super.viewDidLoad()
                self.tableView.registerNib(UINib(nibName: "TVCellForMe", bundle: nil), forCellReuseIdentifier: "mecell")
        self.tableView.registerNib(UINib(nibName: "TVCellForMeEmail", bundle: nil), forCellReuseIdentifier: "emailcell")
        currentUser = PFUser.currentUser()!
        //self.tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return Data.count
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Data[section]!.count
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 && indexPath.row == 0{
            return 80
        }
        return UITableViewAutomaticDimension
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch(Data[indexPath.section]![indexPath.row]){
            case "Me":
                let cell:TVCellForMe = tableView.dequeueReusableCellWithIdentifier("mecell", forIndexPath: indexPath) as! TVCellForMe
                
                cell.setDisplayName(self.currentUser!["DisplayName"] as! String)
                return cell
        case "Email":
            let cell:TVCellForMeEmail = tableView.dequeueReusableCellWithIdentifier("emailcell", forIndexPath: indexPath) as! TVCellForMeEmail
            return cell
        default:
            let cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
            cell.textLabel?.text = Data[indexPath.section]![indexPath.row];
            cell.accessoryType = .DisclosureIndicator
            return cell
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 1{
            switch(indexPath.row){
            case 1:
                self.performSegueWithIdentifier("showlist", sender: self)
                break
            case 0:
                self.performSegueWithIdentifier("showrequest", sender: self)
                break
            default:
                break
            }
        }
        
        if indexPath.section == 2{
            PFUser.logOutInBackgroundWithBlock({ (error) -> Void in
                self.tabBarController?.selectedIndex = 0
            })
        }
    }

}
