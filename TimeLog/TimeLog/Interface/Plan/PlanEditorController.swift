//
//  PlanEditorController.swift
//  TimeLog
//
//  Created by 黄穆斌 on 16/7/14.
//  Copyright © 2016年 Myron. All rights reserved.
//

import UIKit

class PlanEditorController: EditorController {
    
    // MARK: - Life cycle
    
    override func deploy() {
        view.layoutIfNeeded()
        deployValue()
        deployBackView()
        deployPicker()
        nameTextField.becomeFirstResponder()
    }
    
    // MARK: - Value
    
    func deployValue() {
        if let data = index.takePlan() {
            nameTextField.text  = data.name
            noteTextView.note   = data.note
            dayPicker.selectRow(Int(data.days - 1), inComponent: 0, animated: false)
            timePicker.selectRow(Int(data.time / 360 - 1), inComponent: 0, animated: false)
            idleButton.selected = data.idle
        } else {
            deleteButton.enabled = false
            saveButton.enabled = false
        }
    }
    
    // MARK: - Back View
    
    //@IBOutlet weak var centerLayout: NSLayoutConstraint!
    var layers = [CALayer]()
    
    func deployBackView() {
        for layer in layers {
            layer.removeFromSuperlayer()
        }
        layers.removeAll(keepCapacity: true)
        
        let lines: [CGFloat] = [50, 120, 190]
        for line in lines {
            let layer = Drawer.line(view.bounds, x1: 10, y1: line, x2: view.bounds.width - 10, y2: line, w: 1, dashPhase: 10)
            layer.strokeColor = AppTint.mainColor().CGColor
            layers.append(layer)
            view.layer.insertSublayer(layer, atIndex: 0)
        }
    }
    
    @IBAction func tapAction(sender: UITapGestureRecognizer) {
        nameTextField.resignFirstResponder()
        noteTextView.resignFirstResponder()
    }
    
    
    // MARK: - Name
    
    @IBOutlet weak var nameTextField: TextField!
    
    @IBAction func textFieldEditingChanged(sender: TextField) {
        saveButton.enabled = (sender.text?.isEmpty == false)
    }
    
    // MARK: - Days
    
    @IBOutlet weak var dayPicker: PickerView!
    @IBOutlet weak var timePicker: PickerView!
    
    func deployPicker() {
        dayPicker.selectRow(9, inComponent: 0, animated: true)
        timePicker.selectRow(9, inComponent: 0, animated: true)
    }
    
    // MARK: - Note
    
    @IBOutlet weak var noteTextView: TextView!
    
    // MARK: - Buttons
    
    @IBOutlet weak var deleteButton: Button!
    @IBOutlet weak var idleButton: Button!
    @IBOutlet weak var saveButton: Button!
    
    //var actions: ((Bool) -> Void)?
    
    @IBAction func cancelAction(sender: Button) {
        NSNotificationCenter.defaultCenter().removeObserver(self)
        action?(nil)
    }
    
    @IBAction func deleteAction(sender: Button) {
        if let i = index.index {
            AppData.removePlan(index.idle, index: i)
            action?(["type": "delete"])
        }
    }
    
    @IBAction func idleAction(sender: Button) {
        sender.selected = !sender.selected
    }
    
    @IBAction func saveAction(sender: Button) {
        NSNotificationCenter.defaultCenter().removeObserver(self)
        
        var data: Plan
        
        if let plan = index.takePlan() {
            data = plan
            AppData.orderChanged(plan.idle, now: idleButton.selected, id: plan.id)
        } else {
            data = AppData.addPlan()
            data.idle = idleButton.selected
        }
        
        data.name = nameTextField.text
        data.days = Double(dayPicker.selectedRowInComponent(0) + 1)
        data.time = Double(timePicker.selectedRowInComponent(0) + 1) * 360
        data.note = noteTextView.note
        
        AppData.save()
        
        action?(true)
    }
    
    // MARK: - Keyboard
    
//    func keyboard(info: NSNotification) {
//        if let value = info.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
//            let height = value.CGRectValue().height
//            let move = -height / 2
//            UIView.animateWithDuration(0.3) {
//                self.centerLayout.constant = move
//                self.view.layoutIfNeeded()
//            }
//        }
//    }
//    
//    func keyboardHide() {
//        UIView.animateWithDuration(0.3) { 
//            self.centerLayout.constant = 0
//            self.view.layoutIfNeeded()
//        }
//    }
}
