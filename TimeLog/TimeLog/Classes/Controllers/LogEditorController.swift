//
//  LogEditorController.swift
//  TimeLog
//
//  Created by 黄穆斌 on 16/7/14.
//  Copyright © 2016年 Myron. All rights reserved.
//

import UIKit

class LogEditorController: UIViewController {

    // MARK: - Values
    
    var index: Int = 0
    var idle: Bool = false
    var log: Log?
    
    var format = NSDateFormatter()
    
    func deployValue() {
        format.dateFormat = "yyyy-MM-dd HH:mm"
        
        planNameButton.note = idle ? AppData.shared.idles[index].name! : AppData.shared.plans[index].name!
        planNameButton.noteToTitle()
        
        
        
        if let log = log {
            noteTextView.note = log.note
            
            startDayButton.note = format.stringFromDate(NSDate(timeIntervalSince1970: log.start))
            endDayButton.note = format.stringFromDate(NSDate(timeIntervalSince1970: log.end))
        } else {
            let end = Clock.unitDate(NSDate()).timeIntervalSince1970
            startDayButton.note = format.stringFromDate(NSDate(timeIntervalSince1970: end - 1800))
            endDayButton.note = format.stringFromDate(NSDate(timeIntervalSince1970: end))
        }
        startDayButton.setTitle("开始于：\(startDayButton.note)", forState: .Normal)
        endDayButton.setTitle("结束于：\(endDayButton.note)", forState: .Normal)
    }
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layoutIfNeeded()
        
        deployBack()
        deployValue()
        startDayButton.selected = false
        endDayButton.selected = false
    }
    
    // MARK: - Back
    
    @IBOutlet weak var backView: View!
    var layers = [CALayer]()
    @IBOutlet var tapGesture: UITapGestureRecognizer!
    @IBAction func tapGestureAction(sender: UITapGestureRecognizer) {
        self.noteTextView.resignFirstResponder()
    }
    
    func deployBack() {
        let lines: [CGFloat] = [50, 130, backView.bounds.height - 50]
        
        for line in lines {
            let layer = Drawer.line(backView.bounds, x1: 20, y1: line, x2: backView.bounds.width - 20, y2: line, w: 1, dashPhase: 0)
            layer.strokeColor = AppTint.mainColor().CGColor
            layers.append(layer)
            backView.layer.insertSublayer(layer, atIndex: 0)
        }
    }
    
    func layerAnimation(show: Bool) {
        CATransaction.begin()
        CATransaction.setAnimationDuration(0.5)
        CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut))
        layers[1].position.y += (show ? 150 : -150)
        layers[2].position.y += (show ? 150 : -150)
        CATransaction.commit()
    }
    
    @IBOutlet var swipeGesture: UISwipeGestureRecognizer!
    
    @IBAction func swipeGestureAction(sender: UISwipeGestureRecognizer) {
        UIView.animateWithDuration(0.5) {
            self.choicer?.frame.origin.x = self.backView.frame.origin.x
        }
    }
    
    // MARK: - Plan Name
    
    var choicer: PlanChoicer?
    
    @IBOutlet weak var planNameButton: Button!
    
    @IBAction func planNameChoiceAction(sender: Button) {
        if choicer == nil {
            // Take
            let controller = UIStoryboard(name: "TimeLog", bundle: nil).instantiateViewControllerWithIdentifier("PlanChoicer") as! PlanChoicerController
            choicer = controller.choicer
            
            // deploy
            choicer?.index  = index
            choicer?.idle   = idle
            choicer?.action = choicerAction
            choicer?.frame  = CGRect(x: view.bounds.width, y: 0, width: 0, height: 0)
            choicer?.deploy()
            view.addSubview(choicer!)
            
            //print("\(self) - \(#function): Choicer.delegate = \(choicer!.tableView.delegate)")
        }
        // Choicer
        choicer?.frame = CGRect(x: view.bounds.width, y: backView.frame.origin.y, width: backView.bounds.width, height: backView.bounds.height)
        UIView.animateWithDuration(0.5) {
            self.choicer?.frame.origin.x = self.backView.frame.origin.x
        }
        
        // Gesture
        tapGesture.enabled = false
        swipeGesture.enabled = true
        
        // Keyboard
        noteTextView.resignFirstResponder()
        
    }
    
    func choicerAction(i: Int) {
        // Update
        index = i
        planNameButton.note = idle ? AppData.shared.idles[i].name! : AppData.shared.plans[i].name!
        planNameButton.noteToTitle()
        
        // Animation
        UIView.animateWithDuration(0.5) {
            self.choicer?.frame.origin.x = self.view.bounds.width
        }
        
        // Gesture
        tapGesture.enabled = true
        swipeGesture.enabled = false
    }
    
    // MARK: - Time Choice
    
    @IBOutlet weak var startDayButton: Button!
    @IBOutlet weak var endDayButton: Button!
    
    @IBOutlet weak var datePickerHeightLayout: NSLayoutConstraint!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBAction func timeChoiceAction(sender: Button) {
        switch (sender === startDayButton, startDayButton.selected, endDayButton.selected) {
        case (_, false, false):
            datePicker.setDate(format.dateFromString(sender.note)!, animated: true)
            sender.selected = true
            self.noteTextView.resignFirstResponder()
            UIView.animateWithDuration(0.5) {
                self.datePickerHeightLayout.constant = 150
                self.view.layoutIfNeeded()
            }
            layerAnimation(true)
        case (true, true, false), (false, false, true):
            sender.selected = false
            UIView.animateWithDuration(0.5) {
                self.datePickerHeightLayout.constant = 0
                self.view.layoutIfNeeded()
            }
            layerAnimation(false)
        case (true, false, true):
            datePicker.setDate(format.dateFromString(sender.note)!, animated: true)
            sender.selected = true
            endDayButton.selected = false
        case (false, true, false):
            datePicker.setDate(format.dateFromString(sender.note)!, animated: true)
            sender.selected = true
            startDayButton.selected = false
        default:
            break
        }
    }
    
    @IBAction func datePickerValueChangedAction(sender: UIDatePicker) {
        if startDayButton.selected {
            startDayButton.note = format.stringFromDate(sender.date)
            startDayButton.setTitle("开始于：\(startDayButton.note)", forState: .Normal)
            let start = sender.date.timeIntervalSince1970
            let end   = format.dateFromString(endDayButton.note)!.timeIntervalSince1970
            if start >= end {
                let day = NSDate(timeIntervalSince1970: start + 300)
                endDayButton.note = format.stringFromDate(day)
                endDayButton.setTitle("结束于：\(endDayButton.note)", forState: .Normal)
            }
        } else {
            endDayButton.note = format.stringFromDate(sender.date)
            endDayButton.setTitle("结束于：\(endDayButton.note)", forState: .Normal)
            let end   = sender.date.timeIntervalSince1970
            let start = format.dateFromString(startDayButton.note)!.timeIntervalSince1970
            if start >= end {
                let day = NSDate(timeIntervalSince1970: end - 300)
                startDayButton.note = format.stringFromDate(day)
                startDayButton.setTitle("开始于：\(startDayButton.note)", forState: .Normal)
            }
        }
    }
    
    // MARK: - Note
    
    @IBOutlet weak var noteTextView: TextView!
    
    // MARK: - Actions
    
    @IBAction func cancelAction(sender: Button) {
        dismissViewControllerAnimated(false, completion: nil)
    }
    
    @IBAction func saveAction(sender: Button) {
        if log == nil {
            log = AppData.addLog(AppData.shared[idle, index])
        }
        
        log?.start    = format.dateFromString(startDayButton.note)!.timeIntervalSince1970
        log?.end      = format.dateFromString(endDayButton.note)!.timeIntervalSince1970
        log?.duration = log!.end - log!.start
        log?.note     = noteTextView.note
        
        AppData.logSplit(log!)
        
        log?.plan?.updateDay(NSDate())
        //log?.plan?.updateTotal()
        
        Notify.post(NotifyType.Update, userInfo: ["idle": idle, "index": index])
        
        dismissViewControllerAnimated(false, completion: nil)
    }
    
}
