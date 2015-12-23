//
//  UserHeaderCell.swift
//  Yolo
//
//  Created by Boran Liu on 11/13/15.
//  Copyright © 2015 Yicheng/Boran. All rights reserved.
//

import UIKit

class UserHeaderCell: UITableViewCell {
    @IBOutlet var profilePic: UIImageView!
    @IBOutlet var eventsCreated: UILabel!
    @IBOutlet var eventsJoined: UILabel!
    @IBOutlet var status: UILabel!
    
    var header: PFObject? {
        didSet {
            if let setHeader = header {
                eventsCreated.text = "0"
                eventsJoined.text = "1"
                status.text = "hello"
                let image = setHeader["profile_picture"] as? PFFile
                image?.getDataInBackgroundWithBlock {(imageData, error) -> Void in
                    if error == nil {
                        if let imageData = imageData {
                            self.profilePic.image = UIImage(data:imageData)
                        }
                    }
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
