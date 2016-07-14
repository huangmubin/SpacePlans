//
//  PlanEditorController.swift
//  TimeLog
//
//  Created by 黄穆斌 on 16/7/14.
//  Copyright © 2016年 Myron. All rights reserved.
//

import UIKit

class PlanEditorController: UIViewController {

    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.layoutIfNeeded()
        
        deployBackView()
        deployPicker()
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
    
    // MARK: - Days
    
    @IBOutlet weak var dayPicker: PickerView!
    @IBOutlet weak var timePicker: PickerView!
    
    func deployPicker() {
        dayPicker.selectRow(9, inComponent: 0, animated: true)
        timePicker.selectRow(9, inComponent: 0, animated: true)
    }
    
}
