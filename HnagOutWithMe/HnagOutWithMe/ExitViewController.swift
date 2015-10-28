//
//  ExitViewController.swift
//  HnagOutWithMe
//
//  Created by Yicheng Liang on 10/27/15.
//  Copyright © 2015 Yicheng/Boran. All rights reserved.
//

import UIKit

class ExitViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //For testing. Whne logout button is pressed, navigate to login page.
    @IBAction func LogOut(sender: AnyObject) {
        PFUser.logOutInBackgroundWithBlock{(error: NSError?) -> Void in
            let logInPage = self.storyboard?.instantiateViewControllerWithIdentifier("LogIn") as! ViewController
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.window?.rootViewController = logInPage
            
        }
       
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
