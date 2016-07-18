//
//  MenuController.swift
//  TimeLog
//
//  Created by 黄穆斌 on 16/7/17.
//  Copyright © 2016年 Myron. All rights reserved.
//

import UIKit

class MenuController: ViewController {

    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.insertSubview(backgroundEffectView, atIndex: 0)
        showingView = ViewController.initNib(show)
        showingView.view.frame = ViewFrame
        showingView.deploy()
        view.addSubview(showingView.view)
    }
    
    // MARK: - Back ground
    
    @IBOutlet weak var backgroundEffectView: UIVisualEffectView!
    
    
    // MARK: - Menu

    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var rightButton: Button!
    @IBOutlet weak var leftButton: Button!
    
    @IBAction func rightAction(sender: Button) {
        var index = showingView.index
        if index.type {
            index.index = nil
        } else {
            index.deital = nil
        }
        editorDeploy(index)
    }
    @IBAction func leftAction(sender: Button) {
        
    }
    
    // MARK: - Buttons
    
    @IBOutlet var navigationButtons: [Button]!
    
    @IBAction func navigationAction(sender: Button) {
        print("note \(sender.note); show \(show)")
        if sender.note == show {
            animateShow(true)
        } else {
            show = sender.note
            let new = ViewController.initNib(sender.note)
            new.view.frame = CGRect(x: 0, y: ScreenHeight, width: ViewFrame.width, height: ViewFrame.height)
            new.actions = showingActions
            new.gesture = gestureSwith
            new.deploy()
            view.addSubview(new.view)
            animateChange(new)
        }
    }
    
    
    // MARK: - Showing
    
    var showingView: ViewController!
    
    /// 当前显示的视图标识
    var show: String {
        set {
            NSUserDefaults.standardUserDefaults().setObject(newValue, forKey: "ShowViewIdentify")
        }
        get {
            return (NSUserDefaults.standardUserDefaults().objectForKey("ShowViewIdentify") as? String) ?? "Plan"
        }
    }
    
    /*
     type: "LogAdd", "Edit", "Timer", "Select"
     index: DataIndex
     */
    func showingActions(data: [String: AnyObject]) {
        
    }
//
    // MARK: - Editor
    
    var editor: EditorController!
    
    func editorDeploy(index: DataIndex) {
        panGesture.enabled = false
        
        editor = EditorController.initNib(index.type ? "Plan" : "Log", identifier: index.type ? "PlanEditor" : "LogEditor")
        
        editor.index = index
        
        editor.view.frame = ViewFrame
        editor.view.frame.origin.y = ScreenHeight
        
        editor.action = editorAction
        view.addSubview(editor.view)
        editor.deploy()
        editorAnimation(true)
    }
    
    func editorAction(data: AnyObject?) {
        if data == nil {
            showingView.update(nil)
        } else {
            showingView.update(data)
        }
        
        editorAnimation(false)
    }
    
    func editorAnimation(show: Bool) {
        UIView.animateWithDuration(0.3, animations: { 
            self.editor.view.frame.origin.y = show ? StatusBarHeight : ScreenHeight
            }) { (finish) in
                if !show {
                    self.editor.view.removeFromSuperview()
                    self.editor = nil
                    self.panGesture.enabled = true
                }
        }
    }
    
    // MARK: - Gesture
    
    
    @IBOutlet var panGesture: UIPanGestureRecognizer!
    
    var origin = ViewFrame.origin.y
    
    @IBAction func panGestureAction(sender: UIPanGestureRecognizer) {
        
        switch sender.state {
        case .Began:
            origin = showingView.view.frame.origin.y
            self.showingView.view.layer.shadowOffset = CGSize(width: 0, height: 0)
        case .Changed:
            UIView.animateWithDuration(0.01) {
                self.showingView.view.frame.origin.y = sender.translationInView(self.view).y + self.origin
            }
        default:
            if self.showingView.view.frame.origin.y < 50 {
                animateShow(true)
            } else if self.showingView.view.frame.origin.y >= ViewFrame.height / 3 {
                animateShow(false)
            } else {
                animationShowDay()
            }
        }
    }
    
    func gestureSwith(open: Bool) {
        panGesture.enabled = open
    }
    
    // MARK: - Animation
    
    func animateShow(push: Bool) {
        UIView.animateWithDuration(0.3) { 
            self.showingView.view.frame.origin.y = push ? ViewFrame.origin.y : 220
        }
        self.showingView.view.layer.shadowOffset = CGSize(width: 0, height: push ? 1 : -1)
    }
    
    func animationShowDay() {
        UIView.animateWithDuration(0.3) {
            self.showingView.view.frame.origin.y = 58
        }
        self.showingView.view.layer.shadowOffset = CGSize(width: 0, height: -1)
    }
    
    func animateChange(new: ViewController) {
        UIView.animateWithDuration(0.5, animations: { 
            self.showingView.view.frame.origin.y = ScreenHeight
            new.view.frame = ViewFrame
            }) { (finish) in
                self.showingView.view.removeFromSuperview()
                self.showingView = new
        }
    }
    

}
