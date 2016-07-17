//
//  LogListController.swift
//  TimeLog
//
//  Created by 黄穆斌 on 16/7/16.
//  Copyright © 2016年 Myron. All rights reserved.
//

import UIKit

class LogListController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK: - Values
    
    var index: Int = 0
    var actions: ((Int, NSIndexPath) -> Void)?
    
    
    var timeFormat = NSDateFormatter()
    var dayFormat = NSDateFormatter()
    
    // MARK: - Load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timeFormat.dateFormat    = "始于: HH:mm"
        dayFormat.dateFormat = "yyyy - MM - dd"
    }
    
    func deploy() {
        tableView.reloadData()
    }
    
    // MARK: - Label
    
    @IBOutlet weak var label: UILabel!
    
    // MARK: - TableView
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        //print("\(self) - \(#function): \(AppData.shared.plans[index].groups.count)")
        return AppData.shared.plans[index].groups.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print("\(self) - \(#function): section: \(section); count: \(AppData.shared.plans[index].groups[section].count)")
        return AppData.shared.plans[index].groups[section].count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("LogListCell", forIndexPath: indexPath) as! LogListCell
        
        cell.deploy()
        
        cell.index = indexPath
        cell.actions = { [weak self] in
            self?.actions?(self!.index, $0)
        }
        
        let data = AppData.shared.plans[index].groups[indexPath.section][indexPath.row]
        cell.noteLabel.text  = data.note?.isEmpty == false ? data.note : dayFormat.stringFromDate(NSDate(timeIntervalSince1970: data.start))
        cell.startLabel.text = timeFormat.stringFromDate(NSDate(timeIntervalSince1970: data.start))
        cell.timeLabel.text  = "持续: " + Clock.time(data.duration)
        
        return cell
    }

    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return dayFormat.stringFromDate(NSDate(timeIntervalSince1970: AppData.shared.plans[index].groups[section][0].start))
    }
    
    // MARK: UITableViewDelegate

    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
}
