//
//  PlanEditorViewController.swift
//  TimeLog
//
//  Created by 黄穆斌 on 16/7/7.
//  Copyright © 2016年 Myron. All rights reserved.
//

import UIKit

class PlanEditorViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

    // MARK: - Life cycle
    
    var data: Plans?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drawBackground()
        
        if data != nil {
            nameTextField.text = data?.name
            noteTextView.text = data?.note
            dayPicker.selectRow(Int(data!.days) - 1, inComponent: 0, animated: false)
            timePicker.selectRow(Int(data!.time + 1) / 6, inComponent: 0, animated: false)
            idleButton.selected = data!.idle
        } else {
            saveButton.enabled = false
        }
    }
    
    func deployTint() {
        view.backgroundColor = AppTint.backgroundColor()
        nameTextField.textColor = AppTint.textColor()
        dayLabel.textColor = AppTint.textColor()
    }
    
    // MARK: Background
    
    var lines = [CAShapeLayer]()
    func drawBackground() {
        let x: (CGFloat, CGFloat) = (20, AppTint.Width - 20)
        let ys: [CGFloat] = [70,150,265]
        let frame = UIScreen.mainScreen().bounds
        for y in ys {
            let shape = LayerDrawer.line(frame, x1: x.0, y1: y, x2: x.1, y2: y, w: 1, dashPhase: 0)
            shape.strokeColor = AppTint.essentialColor().CGColor
            shape.shadowOpacity = 0.5
            shape.shadowOffset = CGSizeZero
            view.layer.insertSublayer(shape, atIndex: 0)
            lines.append(shape)
        }
    }
    
    // MARK: - Input
    
    
    @IBOutlet weak var nameTextField: TextField!
    @IBOutlet weak var noteTextView: TextView!
    
    @IBAction func nameTextFieldChanged(sender: TextField) {
        saveButton.enabled = sender.text?.isEmpty == false
    }
    
    @IBAction func tapGestureAction(sender: UITapGestureRecognizer) {
        nameTextField.resignFirstResponder()
        noteTextView.resignFirstResponder()
    }
    
    
    // MARK: - Days
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var dayPicker: UIPickerView!
    @IBOutlet weak var timePicker: UIPickerView!
    
    // MARK: UIPickerViewDataSource
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerView === dayPicker ? 999 : 240
    }
    
    // MARK: UIPickerViewDelegate
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        //return pickerView === dayPicker ? "999" : "99.9"
        return pickerView === dayPicker ? "\(row+1)" : String(format: "%.1f", Double(row + 1) / 10)
    }
    
    // MARK: - Buttons
    
    @IBOutlet weak var idleButton: Button!
    @IBOutlet weak var saveButton: Button!
    
    @IBAction func cancelAction(sender: Button) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func deleteAction(sender: Button) {
        if data != nil {
            if let logs = data!.logs {
                for log in logs {
                    AppData.delete(log as! Logs)
                }
            }
            AppData.delete(data!)
            AppData.idlePlan(data!.id)
            AppData.saveData()
            AppData.saveOrder()
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func adleAction(sender: Button) {
        sender.selected = !sender.selected
    }
    
    @IBAction func saveAction(sender: Button) {
        if data == nil {
            data = AppData.addPlan(nil)
            AppData.shared.plans.append(data!)
        }
        
        data?.name = nameTextField.text
        data?.days = Double(dayPicker.selectedRowInComponent(0) + 1)
        data?.time = Double(timePicker.selectedRowInComponent(0) + 1 * 60)
        data?.note = noteTextView.text
        switch (data!.idle, idleButton.selected) {
        case (false, true):
            data?.idle = true
            AppData.idlePlan(data!.id)
            let index = AppData.shared.plans.indexOf(data!)!
            let plan = AppData.shared.plans.removeAtIndex(index)
            AppData.shared.idles.append(plan)
        case (true, false):
            data?.idle = false
            AppData.addOrder(data!.id)
            let index = AppData.shared.idles.indexOf(data!)!
            let plan = AppData.shared.idles.removeAtIndex(index)
            AppData.shared.plans.append(plan)
        default:
            break
        }
        
        
        AppData.saveOrder()
        AppData.saveData()
    }
    
}
