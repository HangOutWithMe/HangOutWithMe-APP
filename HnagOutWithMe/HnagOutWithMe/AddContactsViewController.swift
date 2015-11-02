//
//  AddContactsViewController.swift
//  Yolo
//
//  Created by Boran Liu on 11/2/15.
//  Copyright © 2015 Yicheng/Boran. All rights reserved.
//

import UIKit

class AddContactsViewController: UIViewController {

    @IBOutlet var SearchBar: UITextField!
    
    @IBOutlet var Instruction: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let imageViewSearchBar = UIImageView()
        let searchImage = UIImage(named: "Search")
        imageViewSearchBar.image = searchImage
        imageViewSearchBar.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        view.addSubview(imageViewSearchBar)
        SearchBar.leftView = imageViewSearchBar
        SearchBar.leftViewMode = UITextFieldViewMode.Always

        Instruction.text = "Search your friend using their UserID or Email"
        // Do any additional setup after loading the view.
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
