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
        return "Row \(indexPath.row) in \(indexPath.section)"
    }
    
    override func titleForHeaderAtSession(session: Int) -> String {
        return "Session \(session)"
    }
    
    func viewControllerForIndexPath(indexPath: NSIndexPath) -> UIViewController {
     //   let viewController: userMainPageViewController = userMainPageViewController()
        let storyboard = UIStoryboard(name: "userMainPage", bundle: nil)
        let viewController = storyboard.instantiateViewControllerWithIdentifier("userMainView") as! userMainPageViewController
        let controller: UINavigationController = UINavigationController(rootViewController: viewController)
        
        switch indexPath.row {
        case 0: break
           // viewController.view.backgroundColor = UIColor(red:0.13, green:0.14, blue:0.15, alpha:0)
        case 1: break
           // viewController.view.backgroundColor = UIColor(red:0.95, green:0.95, blue:0.95, alpha:0)
        case 2: break
           // viewController.view.backgroundColor = UIColor(red:0.95, green:0.95, blue:0.95, alpha:0)
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
