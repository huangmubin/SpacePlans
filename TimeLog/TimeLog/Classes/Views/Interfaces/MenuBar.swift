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
        planListButton.titleLabel?.font = AppTint.titleFont()
        planListButton.setTitleColor(AppTint.fontColor().main, forState: .Normal)
    }
    
    // MARK: - Type
    enum Type: String {
        case Plan = "ShowPlan"
        case Day = "ShowDay"
    }
    
    var type: Type = Type.Plan {
        didSet {
            planListButton.hidden = true
            switch type {
            case .Plan:
                planListButton.hidden = false
            case .Day:
                break
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
        } else {
            leftAction?(false)
            leftAnimation("MenuOpen")
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
        planListAction?(planListButton.note == "计划列表")
    }
}
