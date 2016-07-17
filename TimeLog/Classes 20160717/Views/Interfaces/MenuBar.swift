//
//  MenuBar.swift
//  TimeLog
//
//  Created by 黄穆斌 on 16/7/12.
//  Copyright © 2016年 Myron. All rights reserved.
//

import UIKit

class MenuBar: UIView {

    // MARK: - Deploy
    
    func deploy() {
        // planListButton
        planListButton.titleLabel?.font = AppTint.titleFont()
        planListButton.setTitleColor(AppTint.fontColor().main, forState: .Normal)
        
        // dayButton
        dayButton.titleLabel?.font = AppTint.titleFont()
        dayButton.setTitleColor(AppTint.fontColor().main, forState: .Normal)
        dayButton.setTitleColor(AppTint.fontColor().accent, forState: .Selected)
        
        // Bar
        self.planListButton.alpha = 0
        self.logPageControl.alpha = 0
        self.dayButton.alpha = 0
        type = .Plan
        
        self.logPageControl.numberOfPages = AppData.shared.plans.count
        
        // Notify
        Notify.add(self, selector: #selector(reload), type: NotifyType.Reload)
    }
    
    // MARK: - Notify
    
    func reload() {
        self.logPageControl.numberOfPages = AppData.shared.plans.count
    }
    
    // MARK: - Type
    enum Type: String {
        case Plan = "ShowPlan"
        case Log = "ShowLog"
        case Day = "ShowDay"
    }
    
    func setType(id: String) {
        if let new = Type(rawValue: id) {
            type = new
        } else {
            showBarControls()
        }
    }
    
    var type: Type = Type.Plan {
        didSet {
            showBarControls()
        }
    }
    
    func hiddenBarControls() {
        UIView.animateWithDuration(0.5) {
            self.planListButton.alpha = 0
            self.logPageControl.alpha = 0
            self.dayButton.alpha = 0
        }
    }
    
    func showBarControls() {
        switch type {
        case .Plan:
            UIView.animateWithDuration(0.5) {
                self.planListButton.alpha = 1
            }
        case .Log:
            UIView.animateWithDuration(0.5) {
                self.logPageControl.alpha = 1
            }
        case .Day:
            UIView.animateWithDuration(0.5) {
                self.dayButton.alpha = 1
            }
        }
    }
    
    // MAKR: - Left Button
    
    var leftAction: ((Bool) -> Void)?
    
    @IBOutlet weak var leftButton: Button!
    
    @IBAction func leftButtonAction(sender: Button) {
        if leftButton.note == "MenuOpen" {
            leftAction?(true)
            leftAnimation("MenuClose")
            hiddenBarControls()
        } else {
            leftAction?(false)
            leftAnimation("MenuOpen")
            showBarControls()
        }
    }
    
    func leftAnimation(show: String) {
        leftButton.note = show
        UIView.animateWithDuration(0.25, animations: { 
            self.leftButton.alpha = 0
            }) { (finish) in
                self.leftButton.noteToImage()
                 UIView.animateWithDuration(0.25) {
                    self.leftButton.alpha = 1
                 }
        }
        rightAnimation(show != "MenuOpen")
    }

    // MARK: - Right Button
    
    var rightAction: ((String) -> Void)?
    
    @IBOutlet weak var rightButton: Button!
    
    @IBAction func rightButtonAction(sender: Button) {
        rightAction?(sender.note)
    }
    
    func rightAnimation(hide: Bool) {
        UIView.animateWithDuration(0.5) { 
            self.rightButton.alpha = hide ? 0 : 1
        }
    }
    
    // MARK: - Plan List Button
    
    var planListAction: ((Bool) -> Void)?
    
    @IBOutlet weak var planListButton: Button!
    
    @IBAction func planListAction(sender: Button) {
        planListButton.note = planListButton.note == "计划列表" ? "闲置列表" : "计划列表"
        planListButton.noteToTitle()
        planListAction?(planListButton.note == "闲置列表")
    }
    
    // MARK: - Log List Bar
    
    var logListAction: ((Int) -> Void)?
    
    var logIndex: Int {
        set {
            logPageControl.currentPage = newValue
        }
        get {
            return logPageControl.currentPage
        }
    }
    
    @IBOutlet weak var logPageControl: PageControl!
    
    @IBAction func logPageValueChanged(sender: PageControl) {
        logListAction?(logPageControl.currentPage)
    }
    
    // MARK: - Day Bar
    
    var dayAction: ((Bool, String) -> String)?
    
    @IBOutlet weak var dayButton: Button!
    
    @IBAction func dayButtonAction(sender: Button) {
        dayButton.selected = !dayButton.selected
        if let action = dayAction {
            dayButton.note = action(dayButton.selected, dayButton.note)
            dayButton.noteToTitle()
        }
    }
}
