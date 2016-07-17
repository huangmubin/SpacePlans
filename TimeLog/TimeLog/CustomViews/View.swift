//
//  View.swift
//  TimeLog
//
//  Created by 黄穆斌 on 16/7/12.
//  Copyright © 2016年 Myron. All rights reserved.
//

import UIKit

class View: UIView {
    
    @IBInspectable var cornerA: CGFloat = 0
    @IBInspectable var cornerB: CGFloat = 0
    @IBInspectable var cornerC: CGFloat = 0
    @IBInspectable var cornerD: CGFloat = 0
    @IBInspectable var background: UIColor = AppTint.backColor()
    
    @IBInspectable var opacity: Float = 0
    @IBInspectable var offsetW: CGFloat = 0
    @IBInspectable var offsetH: CGFloat = 0
    @IBInspectable var radius: CGFloat = 0
    
    override func drawRect(rect: CGRect) {
        let path = Drawer.roundedPath(rect.size, a: cornerA, b: cornerB, c: cornerC, d: cornerD)
        background.setFill()
        path.fill()
        layer.shadowOpacity = opacity
        layer.shadowOffset = CGSize(width: offsetW, height: offsetH)
        layer.shadowRadius = radius
    }

}

