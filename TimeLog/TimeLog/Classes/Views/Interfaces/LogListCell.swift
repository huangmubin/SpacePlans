//
//  LogListCell.swift
//  TimeLog
//
//  Created by 黄穆斌 on 16/7/16.
//  Copyright © 2016年 Myron. All rights reserved.
//

import UIKit

class LogListCell: UITableViewCell {

    @IBOutlet weak var note: UILabel!
    @IBOutlet weak var start: UILabel!
    @IBOutlet weak var end: UILabel!
    @IBOutlet weak var duration: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
