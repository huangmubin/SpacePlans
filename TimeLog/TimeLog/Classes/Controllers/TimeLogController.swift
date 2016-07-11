//
//  TimeLogController.swift
//  TimeLog
//
//  Created by 黄穆斌 on 16/7/11.
//  Copyright © 2016年 Myron. All rights reserved.
//

import UIKit

class TimeLogController: UIViewController {

    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layoutIfNeeded()
        
        menuView.deploy()
    }
    

    // MARK: - Views
    
    // MARK: Menu View
    @IBOutlet weak var menuView: MenuView!
    
    
    // MARK: - Navigation
     
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }

}
