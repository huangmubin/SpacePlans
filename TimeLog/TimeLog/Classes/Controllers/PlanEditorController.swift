//
//  PlanEditorController.swift
//  TimeLog
//
//  Created by 黄穆斌 on 16/7/14.
//  Copyright © 2016年 Myron. All rights reserved.
//

import UIKit

class PlanEditorController: UIViewController {

    // MARK: - Value
    
    var index: Int?
    var idle: Bool = false
    
    func deployValue() {
        if let index = index {
            let data = idle ? AppData.shared.idles[index] : AppData.shared.plans[index]
            nameTextField.text  = data.name
            noteTextView.note   = data.note
            idle = data.idle
            dayPicker.selectRow(Int(data.days - 1), inComponent: 0, animated: false)
            timePicker.selectRow(Int(data.time / 360 - 1), inComponent: 0, animated: false)
            //print("\(self) - \(#function): index = \(index); name = \(data.name); note = \(data.note); idle = \(idle); days = \(data.days); time = \(data.time);")
        } else {
            //print("\(self) - \(#function): index = \(index); idle = \(idle);")
            deleteButton.enabled = false
            saveButton.enabled = false
        }
        idleButton.selected = idle
    }
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layoutIfNeeded()
        
        deployBackView()
        deployPicker()
        
        deployValue()
    }
    
    // MARK: - Back View
    
    @IBOutlet weak var backView: View!
    
    func deployBackView() {
        let lines: [CGFloat] = [40,backView.bounds.height - 100,backView.bounds.height - 50]
        for line in lines {
            let layer = Drawer.line(backView.bounds, x1: 10, y1: line, x2: backView.bounds.width - 10, y2: line, w: 1, dashPhase: 10)
            layer.strokeColor = AppTint.mainColor().CGColor
            backView.layer.insertSublayer(layer, atIndex: 0)
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
    
    @IBAction func cancelAction(sender: Button) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func deleteAction(sender: Button) {
        if let index = index {
            AppData.removePlan(idle, index: index)
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func idleAction(sender: Button) {
        sender.selected = !sender.selected
    }
    
    @IBAction func saveAction(sender: Button) {
        var data: Plan
        if let index = index {
            data = idle ? AppData.shared.idles[index] : AppData.shared.plans[index]
            AppData.orderChanged(idle, now: idleButton.selected, id: data.id)
        } else {
            data = AppData.addPlan()
            data.idle = idleButton.selected
        }
        
        data.name = nameTextField.text
        data.days = Double(dayPicker.selectedRowInComponent(0) + 1)
        data.time = Double(timePicker.selectedRowInComponent(0) + 1) * 360
        data.note = noteTextView.note
        
        AppData.save(true, info: nil)
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
}
