//
//  ViewController.swift
//  HnagOutWithMe
//
//  Created by Yicheng Liang on 10/26/15.
//  Copyright © 2015 Yicheng/Boran. All rights reserved.
//

import UIKit
import Foundation
import SystemConfiguration



class ViewController: UIViewController {
    
    @IBOutlet weak var fbLoginButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    //default users
    let defaults = NSUserDefaults.standardUserDefaults()

    
    //MARK: Global Variables for Changing Image Functionality.
   // private var idx: Int = 0
   // private let backGroundArray = [UIImage(named: "img1.jpg"),UIImage(named:"img2.jpg")]
    
    //MARK: View Controller LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameField.alpha = 0
        passwordField.alpha = 0
        loginButton.alpha   = 0
        //Add a boarder line to the bottom of usernamefield.
        let border = CALayer()
        let width = CGFloat(2.0)
        border.borderColor = UIColor.darkGrayColor().CGColor
        border.frame = CGRect(x: 0, y: usernameField.frame.size.height - width, width:  usernameField.frame.size.width, height: usernameField.frame.size.height)
        border.borderWidth = width
        usernameField.layer.addSublayer(border)
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
        loginButton.layer.borderWidth = 0.5
        loginButton.layer.borderColor = UIColor.grayColor().CGColor
        self.loginButton(false)
        
    }
    /**
    @param username
    @param userpassword
    Mark: Authenticate user when they perform a log in. If success, navigate to app main content page,
    otherwise alert message displayed, and stay in login page.
    */
    @IBAction func logInAction(sender: AnyObject) {
        if(isConnectedToNetwork()){
            PFUser.logInWithUsernameInBackground(usernameField.text!, password: passwordField.text!) {
                (user: PFUser?, signupError: NSError?) -> Void in
                //if user is authenticated
                if signupError == nil {
                    // Check that the user has verified their email address
                    if user?.objectForKey("emailVerified") as! Bool == true {
                        dispatch_async(dispatch_get_main_queue()) {
                            // if log in successful, transit to main view.
                            self.presentMainPageView()
                            self.view.endEditing(true)
                            self.defaults.setValue(self.usernameField.text, forKey: "lastUser")
                            
                        }
                    }
                        //if email not verified
                        
                    else {
                        let myAlert = UIAlertController(title:"Email verification ", message:"Please verify your email first!", preferredStyle: UIAlertControllerStyle.Alert);
                        let okAction =  UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
                        myAlert.addAction(okAction);
                        self.presentViewController(myAlert, animated:true, completion:nil);
                        self.view.endEditing(true)
                        PFUser.logOut()
                        
                    }
                    
                } else { // if user is  not authenticated
                    let myAlert = UIAlertController(title:"Error", message:"invalid login information", preferredStyle: UIAlertControllerStyle.Alert);
                    let okAction =  UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
                    myAlert.addAction(okAction);
                    self.presentViewController(myAlert, animated:true, completion:nil);
                    self.view.endEditing(true)
                    PFUser.logOut()
                    
                }
                
            }
        }else {
            //Display an alert message
            let myAlert = UIAlertController(title:"Error", message:"Please Connect to Internet", preferredStyle: UIAlertControllerStyle.Alert);
            
            let okAction =  UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
            myAlert.addAction(okAction);
            self.presentViewController(myAlert, animated:true, completion:nil);

        }

    }

    //Mark
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let imageView = UIImageView()
        let image = UIImage(named: "User No Gender")
        imageView.image = image
        imageView.frame = CGRect(x: 0, y: 0, width: 30, height: 20)
        view.addSubview(imageView)
        usernameField.leftView = imageView
        usernameField.leftViewMode = UITextFieldViewMode.Always
        let imageViewPassword = UIImageView()
        let passwordImage = UIImage(named: "password")
        imageViewPassword.image = passwordImage
        imageViewPassword.frame = CGRect(x: 0, y: 0, width: 30, height: 20)
        view.addSubview(imageViewPassword)
        passwordField.leftView = imageViewPassword
        passwordField.leftViewMode = UITextFieldViewMode.Always
        if(usernameField.text == "") {
            usernameField.text = defaults.stringForKey("lastUser")
        }
        }
    /**
    update newly registered user to parse
    */
    func updateUserInfoToParse() {
        
        let requestParameters = ["fields": "id, email, first_name, last_name"]
        
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
                    let userProfile = "https://graph.facebook.com/" + userId + "/picture?type=large"
                    
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
                let myAlert = UIAlertController(title:"Alert", message:error?.localizedDescription, preferredStyle: UIAlertControllerStyle.Alert);
                
                let okAction =  UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil)
                
                myAlert.addAction(okAction);
                self.presentViewController(myAlert, animated:true, completion:nil);
                
                return
            }
            if(FBSDKAccessToken.currentAccessToken() != nil)
                
            {   self.updateUserInfoToParse()
                //self.performSegueWithIdentifier("Fool", sender: self)

                
            }
            // if log in successful, transit to main view.
           self.presentMainPageView()
            

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
    /**
    Dismiss keyboard when touch on screen
    */
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        view.endEditing(true)
        super.touchesBegan(touches, withEvent: event)
    }
    
    func presentMainPageView(){
        let storyboard = UIStoryboard(name: "userMainPage", bundle: nil)
        let contentPage = storyboard.instantiateViewControllerWithIdentifier("userMainView") as! userMainPageViewController
        let navigationController = UINavigationController(rootViewController: contentPage)
        let menuController: menuViewController = menuViewController(viewController: navigationController, atIndexPath: NSIndexPath(forRow: 0, inSection: 0))
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        self.presentViewController(menuController, animated: true, completion: nil)

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

