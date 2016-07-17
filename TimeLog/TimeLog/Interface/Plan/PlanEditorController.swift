//
//  PlanEditorController.swift
//  TimeLog
//
//  Created by 黄穆斌 on 16/7/14.
//  Copyright © 2016年 Myron. All rights reserved.
//

import UIKit

class PlanEditorController: ViewController {

    // MARK: - Value
    
    var index: Int?
    var idle: Bool = false
    
    func deployValue() {
        if let index = index {
            let data = idle ? Idles[index] : Plans[index]
            nameTextField.text  = data.name
            noteTextView.note   = data.note
            idle = data.idle
            dayPicker.selectRow(Int(data.days - 1), inComponent: 0, animated: false)
            timePicker.selectRow(Int(data.time / 360 - 1), inComponent: 0, animated: false)
        } else {
            deleteButton.enabled = false
            saveButton.enabled = false
        }
        idleButton.selected = idle
    }
    
    // MARK: - Life cycle
    
    override func deploy() {
        view.layoutIfNeeded()
        deployBackView()
        deployValue()
        deployPicker()
        nameTextField.becomeFirstResponder()
    }
    
    // MARK: - Back View
    
    var layers = [CALayer]()
    
    func deployBackView() {
        for layer in layers {
            layer.removeFromSuperlayer()
        }
        
        let lines: [CGFloat] = [50, 130, view.bounds.height-60]
        for line in lines {
            let layer = Drawer.line(view.bounds, x1: 10, y1: line, x2: view.bounds.width - 10, y2: line, w: 1, dashPhase: 10)
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
        layers[2].frame.origin.y = change
        CATransaction.commit()
        
        UIView.animateWithDuration(0.3) { 
            self.view.frame.size.height = h
        }
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
        actions?(false)
    }
    
    @IBAction func deleteAction(sender: Button) {
        if let index = index {
            AppData.removePlan(idle, index: index)
        }
        actions?(false)
    }
    
    @IBAction func idleAction(sender: Button) {
        sender.selected = !sender.selected
    }
    
    @IBAction func saveAction(sender: Button) {
        var data: Plan
        if let index = index {
            data = idle ? Idles[index] : Plans[index]
            AppData.orderChanged(idle, now: idleButton.selected, id: data.id)
        } else {
            data = AppData.addPlan()
            data.idle = idleButton.selected
        }
        
        data.name = nameTextField.text
        data.days = Double(dayPicker.selectedRowInComponent(0) + 1)
        data.time = Double(timePicker.selectedRowInComponent(0) + 1) * 360
        data.note = noteTextView.note
        
        AppData.save()
        actions?(true)
    }
    
    
}
