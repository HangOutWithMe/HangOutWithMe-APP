//
//  mainPageTabBarController.swift
//  Yolo
//
//  Created by Boran Liu on 11/1/15.
//  Copyright © 2015 Yicheng/Boran. All rights reserved.
//

import UIKit

class mainPageTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.grayColor()
        let button: UIButton = UIButton(type: UIButtonType.Custom)
        button.frame = CGRectMake(0, 0, 50, 35)
        button.setTitle("Menu", forState: UIControlState.Normal)
        button.setTitleColor(UIColor(red:0.3, green:0.69, blue:0.75, alpha:1), forState: UIControlState.Normal)
        button.addTarget(self, action: "leftButtonTouch", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: button)
        self.airSwipeHandler = {() -> Void in
            self.airViewController.showAirViewFromViewController(self.navigationController,  complete: nil)
            return
        }

        // Do any additional setup after loading the view.
    }
//    func getController() -> mainPageTabBarController{
//        return self
//    }
    
    func leftButtonTouch() {
        self.airViewController.showAirViewFromViewController(self.navigationController, complete: nil)
    }

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
