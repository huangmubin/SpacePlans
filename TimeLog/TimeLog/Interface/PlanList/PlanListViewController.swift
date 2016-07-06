//
//  PlanListViewController.swift
//  TimeLog
//
//  Created by 黄穆斌 on 16/7/7.
//  Copyright © 2016年 Myron. All rights reserved.
//

import UIKit

class PlanListViewController: UIViewController {

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

}
