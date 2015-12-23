//
//  MeTableViewController.swift
//  Yolo
//
//  Created by Boran Liu on 11/1/15.
//  Copyright © 2015 Yicheng/Boran. All rights reserved.
//

import UIKit

class MeTableViewController: UITableViewController {
    
    var header: PFObject?
    var events = ["coffee", "movie", "lunch", "gun"]
    
    @IBAction func Logout(sender: AnyObject) {
        PFUser.logOutInBackgroundWithBlock{(error: NSError?) -> Void in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let logInPage = storyboard.instantiateViewControllerWithIdentifier("LogIn") as! ViewController
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.window?.rootViewController = logInPage
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBarHidden = false
        self.tabBarController?.navigationItem.title = "Me"
        let refreshButton = UIBarButtonItem(barButtonSystemItem: .Refresh, target: self, action:"refreshFunc")
        self.tabBarController?.navigationItem.rightBarButtonItem = refreshButton

        refreshFromParse()
        self.tableView.reloadData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    
//    override func viewDidAppear(animated: Bool) {
//        super.viewDidAppear(animated)
//        self.navigationController?.navigationBarHidden = false
//        self.tabBarController?.navigationItem.title = "Me"
//        let refreshButton = UIBarButtonItem(barButtonSystemItem: .Refresh, target: self, action:"refreshFunc")
//        self.tabBarController?.navigationItem.rightBarButtonItem = refreshButton
//    }

    func refreshFunc() {
      let vc = (self.storyboard?.instantiateViewControllerWithIdentifier("testing"))! as UIViewController
      self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func refreshFromParse() {

        let currentUser = PFUser.currentUser()
        if let currUser = currentUser {
                self.header = currUser
                self.tableView.reloadData()
            }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if(section == 0){
            return 1
        }else {
            return events.count
        }
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        tableView.estimatedRowHeight = 400
        tableView.rowHeight = UITableViewAutomaticDimension
        if(indexPath.section == 0){
            let cell = tableView.dequeueReusableCellWithIdentifier("userHeaderCell", forIndexPath: indexPath) as! UserHeaderCell
            cell.header = self.header
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            return cell
        }else{
            let cell = tableView.dequeueReusableCellWithIdentifier("userEventsCell", forIndexPath: indexPath) as! UserEventsCell
            return cell
        }
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
