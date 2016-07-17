//
//  LogListView.swift
//  TimeLog
//
//  Created by 黄穆斌 on 16/7/14.
//  Copyright © 2016年 Myron. All rights reserved.
//

import UIKit

class LogListView: UIView, UIScrollViewDelegate {

    // MARK: Deploy
    
    func deploy() {
        reloadScrollView()
        Notify.add(self, selector: #selector(reloadScrollView), type: NotifyType.Reload)
        Notify.add(self, selector: #selector(updatePlan), type: NotifyType.Update)
    }
    
    func reloadScrollView() {
        scrollView.contentSize = CGSize(width: CGFloat(AppData.shared.plans.count
            ) * AppTint.Width, height: AppTint.Height - 44)
        for log in logLists {
            log.view.removeFromSuperview()
        }
        logLists.removeAll(keepCapacity: true)
        
        for (i,plan) in AppData.shared.plans.enumerate() {
            let logListController = UIStoryboard(name: "TimeLog", bundle: nil).instantiateViewControllerWithIdentifier("LogListController") as! LogListController
            
            logListController.view.frame = CGRect(x: CGFloat(i) * AppTint.Width, y: 0, width: AppTint.Width, height: AppTint.Height - 44)
            logListController.label.text = plan.name
            logListController.index = i
            
            logLists.append(logListController)
            scrollView.addSubview(logListController.view)
            logListController.deploy()
        }
    }
    
    func updatePlan(notify: NSNotification) {
        if let idle = Notify.data(notify, key: "idle") as? Bool, let index = Notify.data(notify, key: "index") as? Int {
            if !idle {
                logLists[index].deploy()
            }
        }
    }
    
    // MARK: - Views
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    var indexAction: ((Int) -> Void)?
    
    var index: Int {
        set {
            scrollView.setContentOffset(CGPoint(x: CGFloat(newValue) * AppTint.Width, y: 0), animated: true)
        }
        get {
            return Int(scrollView.contentOffset.x / AppTint.Width)
        }
    }
    
    var logLists = [LogListController]()
    
    // MARK: - Methods
    
    var decelerating = false
    
    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        decelerating = decelerate
        if !decelerating {
            indexAction?(index)
        }
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        if decelerating {
            indexAction?(index)
        }
    }
    
}
