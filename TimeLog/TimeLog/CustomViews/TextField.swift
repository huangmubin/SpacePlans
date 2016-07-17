//
//  TextField.swift
//  TimeLog
//
//  Created by 黄穆斌 on 16/7/14.
//  Copyright © 2016年 Myron. All rights reserved.
//

import UIKit

class TextField: UITextField, UITextFieldDelegate {

    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        delegate = self
    }
    
    func deploy() {
        delegate = self
        font = AppTint.titleFont()
        textColor = AppTint.fontColor().main
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        resignFirstResponder()
        return true
    }

}
