//
//  PlanListViewController.swift
//  TimeLog
//
//  Created by 黄穆斌 on 16/7/7.
//  Copyright © 2016年 Myron. All rights reserved.
//

import UIKit

class PlanListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        deployMenu()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        deployTint()
    }
    
    func deployTint() {
        view.backgroundColor = AppTint.backgroundColor()
    }
    
    // MARK: - Menu
    
    @IBOutlet weak var menuBarView: MenuBarView!
    
    func deployMenu() {
        menuBarView.addAction = { [weak self] (sender) in
            self?.performSegueWithIdentifier("AddPlan", sender: nil)
        }
    }
    
    // MARK: - TableView
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: UITableViewDataSource
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? AppData.shared.plans.count : AppData.shared.idles.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("PlanListCell", forIndexPath: indexPath) as! PlanListCell
        
        cell.layoutIfNeeded()
        cell.drawShadow()
        
        let data = indexPath.section == 0 ? AppData.shared.plans[indexPath.row] : AppData.shared.idles[indexPath.row]
        cell.updateLabel(indexPath.section == 1)
        
        cell.nameLabel.text = data.name
        cell.allLabel.text = String(format: "合计：%.2f 小时", data.duration() / 3600)
        cell.dayLabel.text = String(format: "今天：%.0f 分钟", data.day(NSDate()) / 60)
        
        return cell
    }
    
    // MARK: UITableViewDelegate
    
    // MARK: - Move Gesture
    
    var moveIndex: NSIndexPath?
    @IBAction func moveCellGestureAction(sender: UILongPressGestureRecognizer) {
        switch sender.state {
        case .Began:
            guard let indexPath = tableView.indexPathForRowAtPoint(sender.locationInView(tableView)) else { return }
            guard indexPath.section == 0 else { return }
            moveIndex = indexPath
            let cell = tableView.cellForRowAtIndexPath(indexPath) as! PlanListCell
            cell.heightLightShadow(true)
        case .Changed:
            guard moveIndex != nil else { return }
            guard let indexPath = tableView.indexPathForRowAtPoint(sender.locationInView(tableView)) else { return }
            guard indexPath.section == 0 else { return }
            if indexPath.row != moveIndex!.row {
                tableView.moveRowAtIndexPath(moveIndex!, toIndexPath: indexPath)
                AppData.move(moveIndex!.row, toIndex: indexPath.row)
                moveIndex = indexPath
            }
        default:
            guard moveIndex != nil else { return }
            AppData.saveOrder()
            let cell = tableView.cellForRowAtIndexPath(moveIndex!) as! PlanListCell
            cell.heightLightShadow(false)
        }
    }
    
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch segue.identifier! {
        case "AddPlan":
            break
        default:
            assert(false, "\(segue.identifier) : \(segue)")
        }
    }
}
