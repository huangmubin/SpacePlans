//
//  LogListView.swift
//  TimeLog
//
//  Created by 黄穆斌 on 16/7/14.
//  Copyright © 2016年 Myron. All rights reserved.
//

import UIKit

class LogListView: UIView, UITableViewDataSource, UITableViewDelegate {

    var index = 0
    var format = NSDateFormatter()
    
    func deploy() {
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
    }
    
    // MARK: - TableView
    
    @IBOutlet weak var tableView: UITableView!
    
    // MAKR: - UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return AppData.shared[false, index].logs?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("LogListCell", forIndexPath: indexPath) as! LogListCell
        
        if let data = AppData.shared[false, index].logs?.objectAtIndex(indexPath.row) as? Log {
            cell.note.text = data.note
            cell.start.text = format.stringFromDate(NSDate(timeIntervalSince1970: data.start))
            cell.end.text = format.stringFromDate(NSDate(timeIntervalSince1970: data.end))
            cell.duration.text = String(format: "%.0f", data.duration / 60)
            cell.start.sizeToFit()
            cell.end.sizeToFit()
            cell.duration.sizeToFit()
        }
        
        return cell
    }
 
}
