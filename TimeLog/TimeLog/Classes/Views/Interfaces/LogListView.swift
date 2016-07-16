//
//  LogListView.swift
//  TimeLog
//
//  Created by 黄穆斌 on 16/7/14.
//  Copyright © 2016年 Myron. All rights reserved.
//

import UIKit

class LogListView: UIView {

    var index = 0
    var format = NSDateFormatter()
    
    func deploy() {
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        scrollView.contentSize = CGSize(width: CGFloat(AppData.shared.plans.count
            ) * AppTint.Width, height: AppTint.Height - 44)
        for (i,plan) in AppData.shared.plans.enumerate() {
            let con = UIStoryboard(name: "TimeLog", bundle: nil).instantiateViewControllerWithIdentifier("LogListController") as! LogListController
            con.view.frame = CGRect(x: CGFloat(i) * AppTint.Width, y: 0, width: AppTint.Width, height: AppTint.Height - 44)
            con.label.text = plan.name
            scrollView.addSubview(con.view)
        }
    }
    
    @IBOutlet weak var scrollView: UIScrollView!
    
}
