//
//  PlanEditorController.swift
//  TimeLog
//
//  Created by 黄穆斌 on 16/7/14.
//  Copyright © 2016年 Myron. All rights reserved.
//

import UIKit

class PlanEditorController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func back() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}
