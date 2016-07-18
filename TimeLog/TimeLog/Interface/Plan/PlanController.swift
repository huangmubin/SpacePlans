//
//  PlanController.swift
//  TimeLog
//
//  Created by 黄穆斌 on 16/7/17.
//  Copyright © 2016年 Myron. All rights reserved.
//

import UIKit

//func deploy() { }
//
//func update(data: AnyObject?) { }
//
//var actions: ((AnyObject?) -> Void)?
//
//var index: DataIndex!

class PlanController: ViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.registerNib(UINib(nibName: "TimeLogCell", bundle: nil), forCellReuseIdentifier: "PlanListCell")
    }
    
    override func deploy() {
        index = DataIndex(type: true, idle: false, index: nil, deital: nil)
        
    }
    
    override func update(data: AnyObject?) {
        if data != nil {
            tableView.reloadData()
        }
    }
    
    // MARK: - Values
    
    // MARK: - Table View
    
    @IBOutlet weak var tableView: UITableView!
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return index.idle ? Idles.count : Plans.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PlanListCell", forIndexPath: indexPath) as! TimeLogCell
        cell.index = indexPath
        cell.actions = cellActions
        cell.gesture = gesture
        cell.deploy()
        
        let data = index.idle ? Idles[indexPath.row] : Plans[indexPath.row]
        cell.titleLabel.text = data.name
        cell.rightLabel.text = Clock.time(data.duration)
        cell.leftLabel.text = Clock.time(data.total)
        
        return cell
    }
    
    
    // MARK: Cell Action
    
    func cellActions(note: String, index: NSIndexPath) {
        actions?(["type": note, "index": index])
    }
}
