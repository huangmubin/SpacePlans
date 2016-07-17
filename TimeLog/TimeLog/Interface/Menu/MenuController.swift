//
//  MenuController.swift
//  TimeLog
//
//  Created by 黄穆斌 on 16/7/17.
//  Copyright © 2016年 Myron. All rights reserved.
//

import UIKit

class MenuController: ViewController {

    // MARK: - Values
    
    /// 当前显示的视图标识
    var show: String {
        set {
            NSUserDefaults.standardUserDefaults().setObject(show, forKey: "ShowViewIdentify")
        }
        get {
            return (NSUserDefaults.standardUserDefaults().objectForKey("ShowViewIdentify") as? String) ?? "Plan"
        }
    }
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addKeyboardNotification()
        showingView = ViewController.initNib(show)
        showingView.view.frame = ViewFrame
        showingView.deploy()
        view.addSubview(showingView.view)
    }
    
    
    // MARK: - Menu

    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var rightButton: Button!
    @IBOutlet weak var leftButton: Button!
    
    @IBAction func rightAction(sender: Button) {
        editorDeploy(true, index: 0)
    }
    @IBAction func leftAction(sender: Button) {
    }
    
    
    
    // MARK: - Buttons
    
    @IBOutlet var navigationButtons: [Button]!
    
    @IBAction func navigationAction(sender: Button) {
        if sender.note == show {
            animateShow(true)
        } else {
            show = sender.note
            let new = ViewController.initNib(sender.note)
            new.view.frame = CGRect(x: 0, y: ScreenHeight, width: ViewFrame.width, height: ViewFrame.height)
            new.deploy()
            view.addSubview(new.view)
            animateChange(new)
        }
    }
    
    
    // MARK: - Showing
    
    var showingView: ViewController!
    
    
    // MARK: - Editor
    
    var editor: ViewController!
    
    func editorDeploy(plan: Bool, index: Int) {
        if plan {
            editor = ViewController.initNib("Plan", identifier: "PlanEditor")
            editor.view.frame = CGRect(x: 0, y: ScreenHeight, width: ScreenWidth, height: 320)
            editor.actions = editorAction
            view.addSubview(editor.view)
            editor.deploy()
            UIView.animateWithDuration(0.3) {
                self.editor.view.frame.origin.y = 20
            }
        } else {
            
        }
    }
    
    func editorAction(data: AnyObject?) {
        let update = data as! Bool
        if update {
            
        } else {
            showingView.update(nil)
        }
        
        UIView.animateWithDuration(0.5, animations: {
            self.editor.view.frame.origin.y = ScreenHeight
            }) { (finish) in
                self.editor.view.removeFromSuperview()
                self.editor = nil
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
    
    
    // MARK: - Keyboard Notification
    
    /** 设置键盘广播方法 */
    func addKeyboardNotification() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(MenuController.KeyboardDidChangeFrameNotification(_:)), name: UIKeyboardWillChangeFrameNotification, object: nil)
        //UIKeyboardWillChangeFrameNotification
        //UIKeyboardDidChangeFrameNotification
    }
    /** 移除键盘广播方法 */
    func removeNotification() {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    // 键盘变化广播方法，每次出现时，就通过改变 searchViewBottomLayout 改变 SearchView 的位置。
    func KeyboardDidChangeFrameNotification(notification: NSNotification) {
        let info: NSDictionary = notification.userInfo!
        if let rect = info.objectForKey(UIKeyboardFrameEndUserInfoKey)?.CGRectValue {
            if let plan = editor as? PlanEditorController {
                plan.setSize(ScreenHeight - StatusBarHeight - rect.height - 4)
            }
        }
    }

}
