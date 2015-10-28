//
//  SignUpViewController.swift
//  HnagOutWithMe
//
//  Created by Yicheng Liang on 10/27/15.
//  Copyright © 2015 Yicheng/Boran. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var passWord: UITextField!
    @IBOutlet weak var userName: UITextField!
    var parseUserName = ""
    var parseEmail = ""
    var parsePassWord = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func signUp(sender: AnyObject) {
        parseEmail = email.text!
        parseUserName = userName.text!
        parsePassWord = passWord.text!
        self.myMethod()
        
    }
    @IBAction func cancelToLogInPage(sender: AnyObject) {
        let logInPage = self.storyboard?.instantiateViewControllerWithIdentifier("LogIn") as! ViewController
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.window?.rootViewController = logInPage
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func myMethod() {
        var user = PFUser()
        user.username = parseUserName
        user.password = parsePassWord
        user.email = parseEmail
        // other fields can be set just like with PFObject
        //user["phone"] = "415-392-0202"
        
        user.signUpInBackgroundWithBlock {
            (succeeded: Bool, error: NSError?) -> Void in
            if let error = error {
                let errorString = error.userInfo["error"] as? NSString
                // Show the errorString somewhere and let the user try again.
            } else {
                // Hooray! Let them use the app now.
            }
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
