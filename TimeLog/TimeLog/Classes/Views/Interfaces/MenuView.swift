//
//  MenuView.swift
//  TimeLog
//
//  Created by 黄穆斌 on 16/7/12.
//  Copyright © 2016年 Myron. All rights reserved.
//

import UIKit

class MenuView: UIView {
    
    // MARK: - Value
    
    @IBOutlet weak var menuShow: UIView!
    
    @IBOutlet weak var leftButton: Button!
    @IBOutlet weak var rightButton: Button!
    
    @IBOutlet var buttons: [Button]!
    
    var type: Type = Type.Plan
    
    // MARK: Layout
    
    @IBOutlet weak var bottomLayout: NSLayoutConstraint!
    @IBOutlet weak var buttonTopLayout: NSLayoutConstraint!
    
    // MARK: Type
    enum Type {
        case Open
        case Plan
        case Log
        case Day
        case Timer
    }
    
    // MARK: - Methods
    
    func deploy() {
        // Self
        backgroundColor = UIColor.clearColor()
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 2
        layer.shadowOpacity = 1
        
        // Menu View
        let sub = Drawer.roundedRect(frame.size, a: 0, b: 0, c: 8, d: 8)
        sub.fillColor = AppTint.backColor().CGColor
        layer.addSublayer(sub)
        
        // Menu Show View
        let show = Drawer.roundedRect(CGSize(width: AppTint.Width, height: AppTint.Height), a: 0, b: 0, c: 8, d: 8)
        show.backgroundColor = AppTint.backColor().CGColor
        menuShow.backgroundColor = UIColor.clearColor()
        menuShow.layer.addSublayer(show)
        
    }
    
    // MARK: Call
    var menuOpen: (() -> Void)?
    var rightAction: (() -> Void)?
    var showView: ((String) -> Void)?
    
    // MARK: Action
    
    @IBAction func menuStatusChangeAction(sender: Button) {
        
    }
    
    @IBAction func menuRightButtonAction(sender: Button) {
        
    }
    
    @IBAction func menuButtonsAction(sender: Button) {
        
    }
    
    // MARK: - Animation
    
    // MARK: Bar Button
    
    func leftButtonAnimation0() {
        UIView.animateWithDuration(0.25, animations: {
            self.leftButton.alpha = 0
            }) { (finish) in
                self.leftButtonAnimation1()
        }
    }
    func leftButtonAnimation1() {
        if self.type == Type.Open {
            self.leftButton.setImage(UIImage(named: "MenuClose"), forState: .Normal)
        } else {
            self.leftButton.setImage(UIImage(named: "MenuOpen"), forState: .Normal)
        }
        UIView.animateWithDuration(0.25, animations: {
            self.leftButton.alpha = 0
            }, completion: { (finish) in
                
        })
    }
    
    func rightButtonAnimation0() {
        switch type {
        case .Plan:
            self.rightButton.setImage(UIImage(named: "AddPlan"), forState: .Normal)
        default:
            break
        }
        UIView.animateWithDuration(0.5, animations: { 
            self.rightButton.alpha = self.type == Type.Open ? 0 : 1
            }) { (finish) in
                
        }
    }
    
    // MARK: Menu Show View
    
    func showViewAnimation0() {
        
    }
}
