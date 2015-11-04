//
//  menuViewController.swift
//  Yolo
//
//  Created by Yicheng Liang on 10/31/15.
//  Copyright © 2015 Yicheng/Boran. All rights reserved.
//

import UIKit

class menuViewController: AirbnbViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        let image = UIImage(named: "Riven-1")
        let imageView = UIImageView(image: image)
        imageView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        self.view.addSubview(imageView)

        // Do any additional setup after loading the view.
    }

    //MARK: AirbnbMenuDataSource
    
    override func numberOfSession() -> Int {
        return 1
    }
    
    override func numberOfRowsInSession(session: Int) -> Int {
        return 3
    }
    
    override func titleForRowAtIndexPath(indexPath: NSIndexPath) -> String {
        if(indexPath.row == 0) {
            return "Yolo"
        }
        if(indexPath.row == 1) {
            return "Help"
        }
        if(indexPath.row == 2) {
            return "Setting"
        }
        return ""
    }
    
    override func titleForHeaderAtSession(session: Int) -> String {
        return "Yolo"
    }
    
    func viewControllerForIndexPath(indexPath: NSIndexPath) -> UIViewController {
        let userMainPageSB = UIStoryboard(name: "userMainPage", bundle: nil)
       // let usermainPageVC = userMainPageSB.instantiateViewControllerWithIdentifier("tabBarView") as! mainPageTabBarController
        var controller = self.vcToReturn as! UINavigationController
        switch indexPath.row {
        case 0:
           // viewController.view.backgroundColor = UIColor(red:0.13, green:0.14, blue:0.15, alpha:0)
            let settingSB = UIStoryboard(name: "userSetting", bundle: nil)
            let viewController = settingSB.instantiateViewControllerWithIdentifier("setting")
            controller = UINavigationController(rootViewController: viewController)
            break
        case 1:
           // viewController.view.backgroundColor = UIColor(red:0.95, green:0.95, blue:0.95, alpha:0)
            let settingSB = UIStoryboard(name: "userSetting", bundle: nil)
            let viewController = settingSB.instantiateViewControllerWithIdentifier("setting")
            controller = UINavigationController(rootViewController: viewController)
            break
        case 2:
           // viewController.view.backgroundColor = UIColor(red:0.95, green:0.95, blue:0.95, alpha:0)
            let settingSB = UIStoryboard(name: "userSetting", bundle: nil)
            let viewController = settingSB.instantiateViewControllerWithIdentifier("setting")
            controller.pushViewController(viewController, animated: true)
            break
        default:
            break
        }
        return controller
    }
    
    //MARK: AirbnbMenuDelegate
    
    func didSelectRowAtIndex(indexPath: NSIndexPath) {
        print("didSelectRowAtIndex:\(indexPath.row)\n", terminator: "")
    }
    
    func shouldSelectRowAtIndex(indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func willShowAirViewController() {
        print("willShowAirViewController\n", terminator: "")
    }
    
    func willHideAirViewController() {
        print("willHideAirViewController\n", terminator: "")
    }
    
    func didHideAirViewController() {
        print("didHideAirViewController\n", terminator: "")
    }
    
    func heightForAirMenuRow() -> CGFloat {
        return 90.0
    }
    
    func indexPathDefaultValue() -> NSIndexPath? {
        return NSIndexPath(index: 2)
    }
}
