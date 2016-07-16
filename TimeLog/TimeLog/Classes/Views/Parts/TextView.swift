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
    
    func deploy() {
        font = AppTint.noteFont()
        textColor = holder ? AppTint.fontColor().sub : AppTint.fontColor().main
        text = holder ? placeholder : note
        delegate = self
    }
    
    // MARK: - Plance Holder
    
    /// 占位符
    @IBInspectable var placeholder: String? = "Test"
    /// 文本内容
    @IBInspectable var note: String? = "" {
        didSet {
            if note?.isEmpty == false {
                holder = false
                text = note
                textColor = AppTint.fontColor().main
            } else {
                holder = true
                text = placeholder
                textColor = AppTint.fontColor().sub
            }
        }
    }
    
    /// 是否使用占位符
    var holder = true
    
    // MARK: - UITextViewDelegate
    
    func textViewShouldBeginEditing(textView: UITextView) -> Bool {
        if holder {
            text = ""
            textColor = AppTint.fontColor().main
        }
        return true
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        note = text
    }
}
