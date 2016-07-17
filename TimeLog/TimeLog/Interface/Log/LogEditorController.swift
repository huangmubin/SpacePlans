//
//  LogEditorController.swift
//  TimeLog
//
//  Created by 黄穆斌 on 16/7/17.
//  Copyright © 2016年 Myron. All rights reserved.
//

import UIKit

class LogEditorController: ViewController, UITableViewDataSource, UITableViewDelegate {

    // MARK: - Values
    
    var index: Int = 0
    var idle: Bool = false
    var log: Log?
    
    var format = NSDateFormatter()
    
    func deployValue() {
        format.dateFormat = "yyyy-MM-dd HH:mm"
        
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
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.layoutIfNeeded()
//        
//        deployBack()
//        deployValue()
//        startDayButton.selected = false
//        endDayButton.selected = false
//    }
//    
    override func deploy() {
        view.layoutIfNeeded()
        
        deployBack()
        deployValue()
        deployPlanName()
        startDayButton.selected = false
        endDayButton.selected = false
    }
    
    // MARK: - Back
    
    //@IBOutlet weak var backView: View!
//    @IBOutlet var tapGesture: UITapGestureRecognizer!
//    @IBAction func tapGestureAction(sender: UITapGestureRecognizer) {
//        self.noteTextView.resignFirstResponder()
//    }
    var layers = [CALayer]()
    
    func deployBack() {
        let lines: [CGFloat] = [50, view.frame.height - 140, view.frame.height - 50]
        
        for line in lines {
            let layer = Drawer.line(view.bounds, x1: 20, y1: line, x2: view.bounds.width - 20, y2: line, w: 1, dashPhase: 0)
            layer.strokeColor = AppTint.mainColor().CGColor
            layers.append(layer)
            view.layer.insertSublayer(layer, atIndex: 0)
        }
    }
    
    func setSize(h: CGFloat) {
        let change = h - layers[2].frame.height
        CATransaction.begin()
        CATransaction.setAnimationDuration(0.3)
        CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut))
        layers[1].frame.origin.y = change
        layers[2].frame.origin.y = change
        CATransaction.commit()
        
        UIView.animateWithDuration(0.3) {
            self.view.frame.size.height = h
            self.choicer.frame.size.height = h
        }
    }
//    
//    func layerAnimation(show: Bool) {
//        CATransaction.begin()
//        CATransaction.setAnimationDuration(0.5)
//        CATransaction.setAnimationTimingFunction(CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut))
//        layers[1].position.y += (show ? 150 : -150)
//        layers[2].position.y += (show ? 150 : -150)
//        CATransaction.commit()
//    }
//    
//    @IBOutlet var swipeGesture: UISwipeGestureRecognizer!
//    
//    @IBAction func swipeGestureAction(sender: UISwipeGestureRecognizer) {
//        UIView.animateWithDuration(0.5) {
//            self.choicer?.frame.origin.x = self.backView.frame.origin.x
//        }
//    }
//    
    // MARK: - Plan Name
    
    @IBOutlet var choicer: View!
    
    @IBOutlet weak var planNameButton: Button!
    
    @IBOutlet weak var tableView: UITableView!
    
    func deployPlanName() {
        choicer.frame = CGRect(x: ScreenWidth, y: 0, width: view.frame.width, height: view.frame.height)
        view.addSubview(choicer)
        planNameButton.note = idle ? Idles[index].name! : Plans[index].name!
        planNameButton.noteToTitle()
        tableViewSelection = index
    }
    
    @IBAction func planNameChoiceAction(sender: Button) {
        planNameChoicerAnimation(true)
    }
    
    func planNameChoicerAnimation(show: Bool) {
        if show {
            UIView.animateWithDuration(0.3) {
                self.choicer.frame.origin.x = 0
            }
        } else {
            planNameButton.note = idle ? Idles[tableViewSelection].name! : Plans[tableViewSelection].name!
            planNameButton.noteToTitle()
            //planNameButton.setTitle(idle ? Idles[tableViewSelection].name : Plans[tableViewSelection].name, forState: .Normal)
            UIView.animateWithDuration(0.3) {
                self.choicer.frame.origin.x = ScreenWidth
            }
        }
    }
    
    // MARK: TableView
    
    var tableViewSelection = 0
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return idle ? Idles.count : Plans.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("LogEditorCell", forIndexPath: indexPath)
        
        cell.textLabel?.font = AppTint.mainFont()
        cell.textLabel?.textColor = AppTint.fontColor().main
        cell.textLabel?.text = idle ? Idles[indexPath.row].name : Plans[indexPath.row].name
        
        cell.accessoryType = tableViewSelection == indexPath.row ? UITableViewCellAccessoryType.Checkmark : UITableViewCellAccessoryType.None
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
            tableViewSelection = indexPath.row
            cell.accessoryType = UITableViewCellAccessoryType.Checkmark
            planNameChoicerAnimation(false)
        }
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
            cell.accessoryType = UITableViewCellAccessoryType.None
        }
    }
    
    // MARK: - Time Choice
    
    @IBOutlet weak var startDayButton: Button!
    @IBOutlet weak var endDayButton: Button!
    
    //@IBOutlet weak var datePickerHeightLayout: NSLayoutConstraint!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBAction func timeChoiceAction(sender: Button) {
        switch (sender === startDayButton, startDayButton.selected, endDayButton.selected) {
        case (_, false, false):
            datePicker.setDate(format.dateFromString(sender.note)!, animated: true)
            sender.selected = true
            self.noteTextView.resignFirstResponder()
//            UIView.animateWithDuration(0.5) {
//                self.datePickerHeightLayout.constant = 150
//                self.view.layoutIfNeeded()
//            }
            //layerAnimation(true)
        case (true, true, false), (false, false, true):
            sender.selected = false
            self.noteTextView.becomeFirstResponder()
//            UIView.animateWithDuration(0.5) {
//                self.datePickerHeightLayout.constant = 0
//                self.view.layoutIfNeeded()
//            }
            //layerAnimation(false)
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
        actions?([index])
        //dismissViewControllerAnimated(false, completion: nil)
    }
    
    @IBAction func saveAction(sender: Button) {
        if log == nil {
            log = AppData.addLog(idle ? Idles[tableViewSelection] : Plans[tableViewSelection])
        } else {
            if index != tableViewSelection {
                log?.plan?.detail?.removeObject(log!)
                log?.plan?.update(UpdateType.TotalAndDuration)
                log?.plan = idle ? Idles[tableViewSelection] : Plans[tableViewSelection]
                log?.plan?.detail?.addObject(log!)
                log?.plan?.update(UpdateType.TotalAndDuration)
            }
        }
        
        log?.start    = format.dateFromString(startDayButton.note)!.timeIntervalSince1970
        log?.end      = format.dateFromString(endDayButton.note)!.timeIntervalSince1970
        log?.duration = log!.end - log!.start
        log?.note     = noteTextView.note
        
        AppData.logSplit(log!)
        
        //log?.plan?.updateDay(NSDate())
        //log?.plan?.updateTotal()
        
        //print("\(self) - \(#function): note = \(log?.note), textView = \(noteTextView.note))")
        //Notify.post(NotifyType.Update, userInfo: ["idle": idle, "index": index])
        //dismissViewControllerAnimated(false, completion: nil)
    }

    
}
