//
//  Button.swift
//  TimeLog
//
//  Created by 黄穆斌 on 16/7/8.
//  Copyright © 2016年 Myron. All rights reserved.
//

import UIKit

class Button: UIButton {

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
        tintColor = AppTint.essentialColor()
        setTitleColor(AppTint.backgroundColor(), forState: .Selected)
    }
    
    override var selected: Bool {
        didSet {
            for image in subviews {
                if image is UIImageView && image !== imageView {
                    image.hidden = true
                }
            }
        }
    }
    
    override var highlighted: Bool {
        didSet {
            layer.shadowOpacity = highlighted ? 0 : 0.5
        }
    }
    
    override func drawRect(rect: CGRect) {
        let path = UIBezierPath(roundedRect: rect, cornerRadius: 4)
        if selected {
            AppTint.essentialColor().setFill()
        } else {
            AppTint.backgroundColor().setFill()
        }
        path.fill()
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 2
    }
    
}
