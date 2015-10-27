//
//  ViewController.swift
//  HnagOutWithMe
//
//  Created by Yicheng Liang on 10/26/15.
//  Copyright © 2015 Yicheng/Boran. All rights reserved.
//

import UIKit



class ViewController: UIViewController {
    
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
        usernameField.alpha = 0;
        passwordField.alpha = 0;
        loginButton.alpha   = 0;
        //imageView.image = UIImage(named: "img1.jpg")

        UIView.animateWithDuration(0.7, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
            self.usernameField.alpha = 1.0
            self.passwordField.alpha = 1.0
            self.loginButton.alpha   = 0.9
            }, completion: nil)
        
        // Notifiying for Changes in the textFields
        usernameField.addTarget(self, action: "textFieldDidChange", forControlEvents: UIControlEvents.EditingChanged)
        passwordField.addTarget(self, action: "textFieldDidChange", forControlEvents: UIControlEvents.EditingChanged)
        
        
        // Visual Effect View for background

        
//        NSTimer.scheduledTimerWithTimeInterval(6, target: self, selector: "changeImage", userInfo: nil, repeats: true)
        self.loginButton(false)
        
    }
    
    
    
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
    
//    func changeImage(){
//        if idx == backGroundArray.count-1{
//            idx = 0
//        }
//        else{
//            idx++
//        }
//        let toImage = backGroundArray[idx];
//        UIView.transitionWithView(self.imageView, duration: 3, options: .TransitionCrossDissolve, animations: {self.imageView.image = toImage}, completion: nil)
//        
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
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

    @IBAction func buttonPressed(sender: AnyObject) {
        self.performSegueWithIdentifier("login", sender: self)
    }
    
    @IBAction func signupPressed(sender: AnyObject) {
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

