//
//  TextField.swift
//  TimeLog
//
//  Created by 黄穆斌 on 16/7/8.
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
    
    // MARK: - UITextFieldDelegate

    func textFieldShouldReturn(textField: UITextField) -> Bool {
        resignFirstResponder()
        return true
    }
    
}
