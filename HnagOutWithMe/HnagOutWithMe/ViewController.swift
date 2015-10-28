//
//  ViewController.swift
//  HnagOutWithMe
//
//  Created by Yicheng Liang on 10/26/15.
//  Copyright © 2015 Yicheng/Boran. All rights reserved.
//

import UIKit



class ViewController: UIViewController {
    
    @IBOutlet weak var fbLoginButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
   
    
    //MARK: Global Variables for Changing Image Functionality.
   // private var idx: Int = 0
   // private let backGroundArray = [UIImage(named: "img1.jpg"),UIImage(named:"img2.jpg")]
    
    //MARK: View Controller LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameField.alpha = 0
        passwordField.alpha = 0
        loginButton.alpha   = 0
        
        //Setting fbloginButton to fb blue
        fbLoginButton.backgroundColor = UIColor(red: 59/255, green: 89/255, blue: 152/255, alpha: 1.0)
        fbLoginButton.imageView?.contentMode = UIViewContentMode.ScaleAspectFit
        UIView.animateWithDuration(0.7, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
            self.usernameField.alpha = 1.0
            self.passwordField.alpha = 1.0
            self.loginButton.alpha   = 0.9
            }, completion: nil)
        
        // Notifiying for Changes in the textFields
        usernameField.addTarget(self, action: "textFieldDidChange", forControlEvents: UIControlEvents.EditingChanged)
        passwordField.addTarget(self, action: "textFieldDidChange", forControlEvents: UIControlEvents.EditingChanged)
        
        self.loginButton(false)
        
    }
    /**
    @param username
    @param userpassword
    Mark: Authenticate user when they perform a log in. If success, navigate to app main content page,
    otherwise alert message displayed, and stay in login page.
    */
    @IBAction func logInAction(sender: AnyObject) {
        PFUser.logInWithUsernameInBackground(usernameField.text!, password: passwordField.text!) {
            (user: PFUser?, signupError: NSError?) -> Void in
        
            if signupError == nil {
                // Do stuff after successful login.
               // println("logged in")
                let contentPage = self.storyboard?.instantiateViewControllerWithIdentifier("Exit") as! ExitViewController
                let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                appDelegate.window?.rootViewController = contentPage
                
            } else {
                var myAlert = UIAlertController(title:"Error", message:"Invalid Log In!", preferredStyle: UIAlertControllerStyle.Alert);
                let okAction =  UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
                myAlert.addAction(okAction);
                self.presentViewController(myAlert, animated:true, completion:nil);
            }

    }
}

    //Mark
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    /**
    update newly registered user to parse
    */
    func updateUserInfoToParse() {
        
        var requestParameters = ["fields": "id, email, first_name, last_name"]
        
        let userDetails = FBSDKGraphRequest(graphPath: "me", parameters: requestParameters)
        
        userDetails.startWithCompletionHandler { (connection, result, error:NSError!) -> Void in
            
            if(error != nil)
            {
                print("\(error.localizedDescription)")
                return
            }
            
            if(result != nil)
            {
                
                let userId:String = result["id"] as! String
                let userFirstName:String? = result["first_name"] as? String
                let userLastName:String? = result["last_name"] as? String
                let userEmail:String? = result["email"] as? String
                
                
                print("\(userEmail)")
                
                let myUser:PFUser = PFUser.currentUser()!
                
                // Save first name
                if(userFirstName != nil)
                {
                    myUser.setObject(userFirstName!, forKey: "first_name")
                    
                }
                
                //Save last name
                if(userLastName != nil)
                {
                    myUser.setObject(userLastName!, forKey: "last_name")
                }
                
                // Save email address
                if(userEmail != nil)
                {
                    myUser.setObject(userEmail!, forKey: "email")
                }
                
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)) {
                    
                    // Get Facebook profile picture
                    var userProfile = "https://graph.facebook.com/" + userId + "/picture?type=large"
                    
                    let profilePictureUrl = NSURL(string: userProfile)
                    
                    let profilePictureData = NSData(contentsOfURL: profilePictureUrl!)
                    
                    if(profilePictureData != nil)
                    {
                        let profileFileObject = PFFile(data:profilePictureData!)
                        myUser.setObject(profileFileObject!, forKey: "profile_picture")
                    }
                    
                    
                    myUser.saveInBackgroundWithBlock({ (success:Bool, error:NSError?) -> Void in
                        
                        if(success)
                        {
                            print("User details are now updated")
                        }
                        
                    })
                    
                }
                
            }
            
        }
        
    }
    /**
    When user pressesd facebook login button, perform this transaction and display alert if error occured.
    */
    @IBAction func facebookLogin(sender: AnyObject) {
        PFFacebookUtils.logInInBackgroundWithReadPermissions(["public_profile","email"], block: { (user:PFUser?, error:NSError?) -> Void in
            
            if(error != nil)
            {
                //Display an alert message
                var myAlert = UIAlertController(title:"Alert", message:error?.localizedDescription, preferredStyle: UIAlertControllerStyle.Alert);
                
                let okAction =  UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
                
                myAlert.addAction(okAction);
                self.presentViewController(myAlert, animated:true, completion:nil);
                
                return
            }
            if(FBSDKAccessToken.currentAccessToken() != nil)
                
            {   self.updateUserInfoToParse()
                self.performSegueWithIdentifier("Fool", sender: self)

                
            }
        })
        
    }
    
    /**
    Enable log in button when both username and password field have some sort of value.
    */
    func loginButton(enabled: Bool) -> () {
        func enable(){
            UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                self.loginButton.backgroundColor = UIColor.colorWithHex("#125688", alpha: 1)
                }, completion: nil)
            loginButton.enabled = true
        }
        func disable(){
            loginButton.enabled = false
            UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                self.loginButton.backgroundColor = UIColor.colorWithHex("#333333",alpha :1)
                }, completion: nil)
        }
        return enabled ? enable() : disable()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    /**
    Detect if textfield has some input
    */
    func textFieldDidChange() {
        if usernameField.text!.isEmpty || passwordField.text!.isEmpty
        {
            self.loginButton(false)
        }
        else
        {
            self.loginButton(true)
        }
    }
    
    @IBAction func backgroundPressed(sender: AnyObject) {
        usernameField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
    }
  
}

//Extension for Color to take Hex Values
extension UIColor{
    
    class func colorWithHex(hex: String, alpha: CGFloat = 1.0) -> UIColor {
        var rgb: CUnsignedInt = 0;
        let scanner = NSScanner(string: hex)
        
        if hex.hasPrefix("#") {
            // skip '#' character
            scanner.scanLocation = 1
        }
        scanner.scanHexInt(&rgb)
        
        let r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let g = CGFloat((rgb & 0xFF00) >> 8) / 255.0
        let b = CGFloat(rgb & 0xFF) / 255.0
        
        return UIColor(red: r, green: g, blue: b, alpha: alpha)
    }

}

