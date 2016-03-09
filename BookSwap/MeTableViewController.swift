//
//  MeTableViewController.swift
//  BookSwap
//
//  Created by Charles Xia on 1/23/16.
//  Copyright © 2016 Charles. All rights reserved.
//

import UIKit

class MeTableViewController: UITableViewController {
    
    let Data:[Int:[String]] = [0:["Me","Email"], 1:["My Request", "My Listing"], 2:["Log out"]]
    var currentUser:BSUser?
    
    override func viewDidLoad() {
        super.viewDidLoad()
                self.tableView.registerNib(UINib(nibName: "TVCellForMe", bundle: nil), forCellReuseIdentifier: "mecell")
        self.tableView.registerNib(UINib(nibName: "TVCellForMeEmail", bundle: nil), forCellReuseIdentifier: "emailcell")
        currentUser = BSGlobal.currentUser
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
//                let img = self.currentUser!["profie"] as! PFFile
//                img.getDataInBackgroundWithBlock({ (data, error) -> Void in
//                    cell.setProfie(UIImage(data: data!)!)
//                })
                cell.setProfie(self.currentUser)
                cell.setDisplayName(self.currentUser!["DisplayName"] as! String)
                return cell
        case "Email":
            let cell:TVCellForMeEmail = tableView.dequeueReusableCellWithIdentifier("emailcell", forIndexPath: indexPath) as! TVCellForMeEmail
            cell.setEmail(self.currentUser!["email"] as! String)
            return cell
        default:
            let cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "cell")
            cell.textLabel?.text = Data[indexPath.section]![indexPath.row];
            cell.accessoryType = .DisclosureIndicator
            return cell
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch(segue.identifier!){
        case "showlist":
            let dest = segue.destinationViewController as! MeListTableViewController
            dest.currentUser = PFUser.currentUser()!
            break
        case "showrequest":
            let dest = segue.destinationViewController as! MeRequestTableViewController
            dest.currentUser = PFUser.currentUser()!
            break
        default:
            break
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
