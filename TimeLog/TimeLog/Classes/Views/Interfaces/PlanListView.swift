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
        tableView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
        
        // Notify
        Notify.remove(self)
        Notify.add(self, selector: #selector(reload), type: NotifyType.Reload)
        Notify.add(self, selector: #selector(update), type: NotifyType.Update)
    }
    
    var actions: ((String, NSIndexPath) -> Void)?
    
    // MARK: - Notify
    
    func reload(notify: NSNotification) {
        if let plan = Notify.data(notify) as? Bool {
            idle = plan
            tableView.reloadData()
            print("Notify NSThread.currentThread() \(NSThread.currentThread())")
        }
    }
    
    func update(notify: NSNotification) {
        if let index = Notify.data(notify) as? Int {
            let indexPath = NSIndexPath(forRow: index, inSection: 0)
            if let cell = tableView.cellForRowAtIndexPath(indexPath) as? PlanListCell {
                print("Notify NSThread.currentThread() \(NSThread.currentThread())")
                updateCell(cell, index: indexPath)
            }
        }
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return idle ? AppData.shared.idles.count : AppData.shared.plans.count
        return 10
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PlanListCell", forIndexPath: indexPath) as! PlanListCell
        cell.deploy()
        
        updateCell(cell, index: indexPath)
        
        return cell
    }
    
    func updateCell(cell: PlanListCell, index: NSIndexPath) {
        cell.deploy()
        
        /*
         let data = idle ? AppData.shared.idles[index.row] : AppData.shared.plans[index.row]
         cell.nameLabel.text = data.name
        */
 
        cell.index   = index
        cell.actions = actions
        
        
        cell.nameLabel.text  = "\(index.row) Cell"
        cell.totalLabel.text = "1000 小时"
        cell.dayLabel.text   = "50 分钟"
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
}
