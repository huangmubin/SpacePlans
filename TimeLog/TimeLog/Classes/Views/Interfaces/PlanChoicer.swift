//
//  PlanChoicer.swift
//  TimeLog
//
//  Created by 黄穆斌 on 16/7/15.
//  Copyright © 2016年 Myron. All rights reserved.
//

import UIKit

class PlanChoicer: UIView, UITableViewDataSource, UITableViewDelegate {

    func deploy() {
        tableView.tintColor = AppTint.mainColor()
        tableView.reloadData()
        tableView.selectRowAtIndexPath(NSIndexPath(forRow: index, inSection: 0), animated: true, scrollPosition: UITableViewScrollPosition.Middle)
    }
    
    // MARK: - Values
    
    var index: Int = 0
    var idle: Bool = false
    var action: ((Int) -> Void)?
    
    // MAKR: - Table View
    
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return idle ? AppData.shared.idles.count : AppData.shared.plans.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PlanChoicerCell", forIndexPath: indexPath)
        
        cell.textLabel?.font = AppTint.titleFont()
        cell.textLabel?.textColor = AppTint.fontColor().main
        cell.textLabel?.text = idle ? AppData.shared.idles[indexPath.row].name : AppData.shared.plans[indexPath.row].name
        
        cell.accessoryType = indexPath.row == index ? UITableViewCellAccessoryType.Checkmark : UITableViewCellAccessoryType.None
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("\(self) - \(#function): Index = \(indexPath.row)")
        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
            index = indexPath.row
            action?(index)
        }
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        print("\(self) - \(#function): Index = \(indexPath.row)")
        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
            cell.accessoryType = UITableViewCellAccessoryType.None
        }
    }
    
    // MARK: - Draw
    
    override func drawRect(rect: CGRect) {
        layer.cornerRadius = 8
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowOpacity = 1
        layer.shadowRadius = 4
        layer.masksToBounds = true
        layer.backgroundColor = AppTint.backColor().CGColor
    }

}
