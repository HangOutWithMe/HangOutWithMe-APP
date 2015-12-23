//
//  UserEventsCell.swift
//  Yolo
//
//  Created by Boran Liu on 11/13/15.
//  Copyright © 2015 Yicheng/Boran. All rights reserved.
//

import UIKit

class UserEventsCell: UITableViewCell {

    @IBOutlet var event: UILabel!
    var singleEvent: PFObject? {
        didSet {
            if let setEvent = singleEvent {
                event.text = "event name here"

                
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
