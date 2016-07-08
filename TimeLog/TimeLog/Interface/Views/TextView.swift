//
//  TextView.swift
//  TimeLog
//
//  Created by 黄穆斌 on 16/7/8.
//  Copyright © 2016年 Myron. All rights reserved.
//

import UIKit

class TextView: UITextView, UITextViewDelegate {

    // MARK: - Init
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        deploy()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        deploy()
    }
    
    var placeholder = "Test"
    
    var holder = true
    func deploy() {
        font = AppTint.detailFont()
        textColor = holder ? AppTint.textDetailColor() : AppTint.textColor()
        delegate = self
        placeholder = text
    }
    
    // MARK: - UITextViewDelegate
    
    func textViewShouldBeginEditing(textView: UITextView) -> Bool {
        if holder {
            text = ""
            textColor = AppTint.textColor()
        }
        return true
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        if text.isEmpty == false {
            holder = false
        } else {
            text = placeholder
            holder = true
            textColor = AppTint.textDetailColor()
        }
    }
}
