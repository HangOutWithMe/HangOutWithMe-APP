//
//  SignUpViewController.swift
//  HnagOutWithMe
//
//  Created by Yicheng Liang on 10/27/15.
//  Copyright © 2015 Yicheng/Boran. All rights reserved.

// As a Note, in password is actually "email", email is actually "password field", 
// so as in storyboard.

import UIKit
import Foundation
import SystemConfiguration

class SignUpViewController: UIViewController {
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var passWord: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    var parseUserName = ""
    var parseEmail = ""
    var parsePassWord = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        email.alpha = 0;
        passWord.alpha = 0;
        signUpButton.alpha = 0;
        UIView.animateWithDuration(0.7, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
            self.email.alpha = 1.0
            self.passWord.alpha = 1.0
            self.signUpButton.alpha   = 0.9
            }, completion: nil)
        // add boarder to password textfield
        let passwordBorder = CALayer()
        let passwordWidth = CGFloat(1.5)
        //passwordBorder.borderColor = UIColor.blackColor().CGColor
        passwordBorder.frame = CGRect(x: 0, y: email.frame.size.height - passwordWidth, width:  email.frame.size.width, height: email.frame.size.height)
        passwordBorder.borderWidth = passwordWidth
        email.layer.addSublayer(passwordBorder)
        email.layer.masksToBounds = true
        //add boarder to textfield at the bottom
        signUpButton.layer.borderWidth = 0.5
        signUpButton.layer.borderColor = UIColor.grayColor().CGColor
        
        // Notifiying for Changes in the textFields
        email.addTarget(self, action: "textFieldDidChange", forControlEvents: UIControlEvents.EditingChanged)
        passWord.addTarget(self, action: "textFieldDidChange", forControlEvents: UIControlEvents.EditingChanged)
        self.signupButton(false)
    }
    /**
    When sign up button in login page is pressed, navigate to sign up page, and sign up user to parse.
    email, username, and password is required to sign up.
    */
    @IBAction func signUp(sender: AnyObject) {
        if(isConnectedToNetwork()) {
            parseEmail = email.text!
            parseUserName = parseEmail
            parsePassWord = passWord.text!
            self.myMethod()
            view.endEditing(true)
        } else {
            //Display an alert message
            let myAlert = UIAlertController(title:"Error", message:"Please Connect to Internet", preferredStyle: UIAlertControllerStyle.Alert);
            
            let okAction =  UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
            myAlert.addAction(okAction);
            self.presentViewController(myAlert, animated:true, completion:nil);
        }
        
        
    }
    
    /**
    Cancel button when user wants to cancel this action with a confirmation, then navigate to login page.
    */
    @IBAction func cancelToLogInPage(sender: AnyObject) {
        let alertController = UIAlertController(title: "Exit?", message: "", preferredStyle: .Alert)
        var cancelAction = UIAlertAction(title: "No", style: UIAlertActionStyle.Cancel) {
            UIAlertAction in
            NSLog("Cancel Pressed")

        }
        // Create the actions
        let okAction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.Destructive) {
            UIAlertAction in
            let logInPage = self.storyboard?.instantiateViewControllerWithIdentifier("LogIn") as! ViewController
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            logInPage.modalTransitionStyle = .FlipHorizontal
            self.presentViewController(logInPage, animated: true, completion: nil)
            self.view.endEditing(true)

        }
        
        // Add the actions
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)

        
        // Present the controller
        self.presentViewController(alertController, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Mark
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        // "password here is email"
        let imageViewPassword = UIImageView()
        let passwordImage = UIImage(named: "password")
        imageViewPassword.image = passwordImage
        imageViewPassword.frame = CGRect(x: 0, y: 0, width: 30, height: 20)
        view.addSubview(imageViewPassword)
        passWord.leftView = imageViewPassword
        passWord.leftViewMode = UITextFieldViewMode.Always
        // "email image here is password"
        let imageViewEmail = UIImageView()
        let emailImage = UIImage(named: "User No Gender")
        imageViewEmail.image = emailImage
        imageViewEmail.frame = CGRect(x: 0, y: 0, width: 30, height: 20)
        view.addSubview(imageViewEmail)
        email.leftView = imageViewEmail
        email.leftViewMode = UITextFieldViewMode.Always
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
                    if let error = error {
                        _ = error.userInfo["error"] as? NSString
                        let myAlert = UIAlertController(title:"Error", message:error.localizedDescription, preferredStyle: UIAlertControllerStyle.Alert);
                        let okAction =  UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
                        myAlert.addAction(okAction);
                        self.presentViewController(myAlert, animated:true, completion:nil);
              
                    } else {
                        // User needs to verify email address before continuing
                        let myAlert = UIAlertController(title: "Email verification",
                            message: "We have sent you an email verification, please check your email to    activate your account.",
                            preferredStyle: UIAlertControllerStyle.Alert
                        )
                        myAlert.addAction(UIAlertAction(title: "OKAY",
                            style: UIAlertActionStyle.Default,
                            handler: { alertController in self.processSignOut()})
                        )
                        // Display alert
                        self.presentViewController(myAlert, animated: true, completion: nil)
                        let contentPage = self.storyboard?.instantiateViewControllerWithIdentifier("LogIn") as! ViewController
                        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                        appDelegate.window?.rootViewController = contentPage
               
                    }
                }
        }
    /**
    sign out user
    */
    func processSignOut(){
        PFUser.logOut()
    }
    /**
    Dismiss keyboard when touch on screen
    */
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
    
    /**
    check internet connection
    */
         func isConnectedToNetwork() -> Bool {
            var zeroAddress = sockaddr_in()
            zeroAddress.sin_len = UInt8(sizeofValue(zeroAddress))
            zeroAddress.sin_family = sa_family_t(AF_INET)
            let defaultRouteReachability = withUnsafePointer(&zeroAddress) {
                SCNetworkReachabilityCreateWithAddress(nil, UnsafePointer($0))
            }
            var flags = SCNetworkReachabilityFlags()
            if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
                return false
            }
            let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
            let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
            return (isReachable && !needsConnection)
        }
    /**
    Enable sign up button when both username and password field have some sort of value.
    */
    func signupButton(enabled: Bool) -> () {
        func enable(){
            UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                self.signUpButton.backgroundColor = UIColor.colorWithHex("#125688", alpha: 1)
                }, completion: nil)
            signUpButton.enabled = true
        }
        func disable(){
            signUpButton.enabled = false
            UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                self.signUpButton.backgroundColor = UIColor.colorWithHex("#333333",alpha :1)
                }, completion: nil)
        }
        return enabled ? enable() : disable()
    }
    
    /**
    Detect if textfield has some input
    */
    func textFieldDidChange() {
        if email.text!.isEmpty || passWord.text!.isEmpty
        {
            self.signupButton(false)
        }
        else
        {
            self.signupButton(true)
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
