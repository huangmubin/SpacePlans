//
//  TextView.swift
//  TimeLog
//
//  Created by 黄穆斌 on 16/7/14.
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
        font = AppTint.noteFont()
        textColor = holder ? AppTint.fontColor().sub : AppTint.fontColor().main
        placeholder = text
        delegate = self
    }
    
    // MARK: - UITextViewDelegate
    
    func textViewShouldBeginEditing(textView: UITextView) -> Bool {
        if holder {
            text = ""
            textColor = AppTint.fontColor().main
        }
        return true
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        if text.isEmpty == false {
            holder = false
        } else {
            text = placeholder
            holder = true
            textColor = AppTint.fontColor().sub
        }
    }
}
