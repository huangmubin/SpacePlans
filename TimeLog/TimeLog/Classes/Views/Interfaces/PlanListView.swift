//
//  PlanListView.swift
//  TimeLog
//
//  Created by 黄穆斌 on 16/7/13.
//  Copyright © 2016年 Myron. All rights reserved.
//

import UIKit

class PlanListView: UIView, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: - Values
    
    /// 显示闲置列表还是计划列表
    var idle: Bool = false
    
    // MARK: Property
    
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Methods
    
    func deploy() {
        backgroundColor = AppTint.backColor()
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return idle ? AppData.shared.idles.count : AppData.shared.plans.count
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PlanListCell", forIndexPath: indexPath) as! PlanListCell
        cell.deploy()
        //cell.textLabel?.text = "\(indexPath.row)"
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
}
