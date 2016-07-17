//
//  PickerView.swift
//  TimeLog
//
//  Created by 黄穆斌 on 16/7/14.
//  Copyright © 2016年 Myron. All rights reserved.
//

import UIKit

class PickerView: UIPickerView, UIPickerViewDataSource, UIPickerViewDelegate {

    // MARK: - Value
    
    @IBInspectable var start: Double = 0
    @IBInspectable var count: Int = 100
    
    @IBInspectable var space: Double = 1
    @IBInspectable var format: String = ""
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        deploy()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        deploy()
    }
    
    func deploy() {
        dataSource = self
        delegate = self
    }
    
    // MARK: - Data Source
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return count
    }
    
    // MARK: - Delegate
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return String(format: format, start + Double(row) * space)
    }
}
