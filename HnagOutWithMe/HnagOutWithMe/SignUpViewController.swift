//
//  SignUpViewController.swift
//  HnagOutWithMe
//
//  Created by Yicheng Liang on 10/27/15.
//  Copyright © 2015 Yicheng/Boran. All rights reserved.

// As a Note, in password is actually "email", email is actually "password field", 
// so as in storyboard.

import UIKit

class SignUpViewController: UIViewController {
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var passWord: UITextField!
   
    var parseUserName = ""
    var parseEmail = ""
    var parsePassWord = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // add boarder to password textfield
        let passwordBorder = CALayer()
        let passwordWidth = CGFloat(2.0)
        //passwordBorder.borderColor = UIColor.blackColor().CGColor
        passwordBorder.frame = CGRect(x: 0, y: passWord.frame.size.height - passwordWidth, width:  passWord.frame.size.width, height: passWord.frame.size.height)
        passwordBorder.borderWidth = passwordWidth
        passWord.layer.addSublayer(passwordBorder)
        passWord.layer.masksToBounds = true
        //add boarder to textfield at the bottom
    }
    /**
    When sign up button in login page is pressed, navigate to sign up page, and sign up user to parse.
    email, username, and password is required to sign up.
    */
    @IBAction func signUp(sender: AnyObject) {
        parseEmail = email.text!
        parseUserName = parseEmail
        parsePassWord = passWord.text!
        self.myMethod()
        view.endEditing(true)
        
    }
    
    /**
    Cancel button when user wants to cancel this action with a confirmation, then navigate to login page.
    */
    @IBAction func cancelToLogInPage(sender: AnyObject) {
        let alertController = UIAlertController(title: "Exit?", message: "Really?", preferredStyle: .Alert)
        var cancelAction = UIAlertAction(title: "No", style: UIAlertActionStyle.Cancel) {
            UIAlertAction in
            NSLog("Cancel Pressed")

        }
        // Create the actions
        let okAction = UIAlertAction(title: "Yes", style: UIAlertActionStyle.Destructive) {
            UIAlertAction in
            let logInPage = self.storyboard?.instantiateViewControllerWithIdentifier("LogIn") as! ViewController
            let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
            appDelegate.window?.rootViewController = logInPage
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
            if(self.parseEmail == "" || self.parsePassWord == ""){
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
                    // User needs to verify email address before continuing
                    let myAlert = UIAlertController(title: "Email verification",
                        message: "We have sent you an email verification, please check your email to activate your account.",
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
    }
    
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
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
