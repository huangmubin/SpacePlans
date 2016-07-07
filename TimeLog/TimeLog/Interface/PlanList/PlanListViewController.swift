//
//  PlanListViewController.swift
//  TimeLog
//
//  Created by 黄穆斌 on 16/7/7.
//  Copyright © 2016年 Myron. All rights reserved.
//

import UIKit

class PlanListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK: - Property
    
    @IBOutlet weak var menuBarView: MenuBarView!
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        deployTint()
    }
    
    func deployTint() {
        view.backgroundColor = AppTint.backgroundColor()
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
        
        if indexPath.section == 0 {
            cell.nameLabel.text = AppData.shared.datas[indexPath.row].name
        } else {
            cell.nameLabel.text = AppData.shared.idles[indexPath.row].name
        }
        return cell
    }
    
    // MARK: UITableViewDelegate
}
