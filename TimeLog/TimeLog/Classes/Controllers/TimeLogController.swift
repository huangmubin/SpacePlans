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
    
    /// 显示中的视图，[Plan, Log, Day]
    var showingView = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        deployMenuView()
        deployMenuBar()
        deployPlanListView()
        
        view.backgroundColor = AppTint.backColor()
        showView(nil)
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        menuView.setNeedsDisplay()
        
    }
    
    // MARK: - Views
    
    func showView(Index: Int?) {
        if let i = Index {
            switch showingView {
            case 0:
                planListView.alpha = 0
            case 1:
                logListView.alpha = 0
            case 2:
                dayChartView.alpha = 0
            default:
                break
            }
            showingView = i
        }
        switch showingView {
        case 0:
            planListView.alpha = 1
        case 1:
            logListView.alpha = 1
        case 2:
            dayChartView.alpha = 1
        default:
            break
        }
    }
    
    // MARK: Menu View
    
    @IBOutlet weak var menuView: MenuView!
    
    func deployMenuView() {
        menuView.open = { [weak self] in
            if let type = $0 {
                switch type {
                case "ShowPlan":
                    self?.showView(0)
                case "ShowLog":
                    self?.showView(1)
                case "ShowDay":
                    self?.showView(2)
                case "ShowTimer":
                    self?.performSegueWithIdentifier("Timer", sender: nil)
                default:
                    break
                }
            }
            self?.menuBar.setType($0 ?? "")
            self?.menuBar.leftAnimation("MenuOpen")
        }
    }
    
    // MARK: Menu Bar
    
    @IBOutlet weak var menuBar: MenuBar!
    
    func deployMenuBar() {
        menuBar.deploy()
        menuBar.leftAction = { [weak self] in
            self?.menuView.push($0)
        }
        menuBar.rightAction = { [weak self] in
            if $0 == "PlanAdd" {
                self?.performSegueWithIdentifier("Edit", sender: nil)
            }
            print("rightAction \($0)")
        }
        menuBar.planListAction = {
            print("planListAction \($0)")
        }
        menuBar.logListAction = {
            print("logListAction \($0)")
        }
        menuBar.dayAction = {
            print("dayAction \($0) \($1)")
            return $1
        }
    }
    
    // MARK: Plan List View
    
    @IBOutlet weak var planListView: PlanListView!
    
    func deployPlanListView() {
        planListView.deploy()
        planListView.actions = { [weak self] in
            self?.performSegueWithIdentifier($0, sender: $1)
            print("Actions = \($0), Index = \($1.row)")
        }
    }
    
    // MARK: Log List View
    
    @IBOutlet weak var logListView: LogListView!
    
    // MARK: Day Chart View
    
    @IBOutlet weak var dayChartView: DayChartView!
    
    
    // MARK: - Navigation
     
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        switch segue.identifier! {
        case "ShowTimer":
            break
        default:
            break
        }
    }

}
