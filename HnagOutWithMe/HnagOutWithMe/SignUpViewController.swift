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
    /**
    When sign up button in login page is pressed, navigate to sign up page, and sign up user to parse.
    email, username, and password is required to sign up.
    */
    @IBAction func signUp(sender: AnyObject) {
        parseEmail = email.text!
        parseUserName = userName.text!
        parsePassWord = passWord.text!
        self.myMethod()
        view.endEditing(true)
        
        
    }
    /**
    Cancel button when user wants to cancel this action, then navigate to login page.
    */
    @IBAction func cancelToLogInPage(sender: AnyObject) {
        let logInPage = self.storyboard?.instantiateViewControllerWithIdentifier("LogIn") as! ViewController
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        appDelegate.window?.rootViewController = logInPage
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /**
    sign up user to parse and perform some error checking like missing information.
    */
    func myMethod() {
        let user = PFUser()
        user.username = parseUserName
        user.password = parsePassWord
        user.email = parseEmail
        
        user.signUpInBackgroundWithBlock {
            (succeeded: Bool, error: NSError?) -> Void in
            if(self.parseEmail == "self." || self.parsePassWord == "" || self.parseUserName == ""){
                let myAlert = UIAlertController(title:"Alert!", message:"Please fill out all needed information!", preferredStyle: UIAlertControllerStyle.Alert);
                let okAction =  UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
                myAlert.addAction(okAction);
                self.presentViewController(myAlert, animated:true, completion:nil);
            }else{
                if let error = error {
                    _ = error.userInfo["error"] as? NSString
                    let myAlert = UIAlertController(title:"Alert!", message:error.localizedDescription, preferredStyle: UIAlertControllerStyle.Alert);
                    let okAction =  UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
                    myAlert.addAction(okAction);
                    self.presentViewController(myAlert, animated:true, completion:nil);
              
                } else {
                    let myAlert = UIAlertController(title:"Congratulation!", message:"You've signed Up!", preferredStyle: UIAlertControllerStyle.Alert);
                    let okAction =  UIAlertAction(title: "Go to App", style: UIAlertActionStyle.Default, handler: nil)
                    myAlert.addAction(okAction);
                    self.presentViewController(myAlert, animated:true, completion:nil);
                    let contentPage = self.storyboard?.instantiateViewControllerWithIdentifier("Exit") as! ExitViewController
                    let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                    appDelegate.window?.rootViewController = contentPage
               
                }
            }
        }
    }
    /**
    Dismiss keyboard when touch on screen
    */
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
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
