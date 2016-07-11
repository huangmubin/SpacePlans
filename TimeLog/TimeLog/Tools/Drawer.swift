//
//  Drawer.swift
//  TimeLog
//
//  Created by 黄穆斌 on 16/7/11.
//  Copyright © 2016年 Myron. All rights reserved.
//

import UIKit

class Drawer: NSObject {
    
    /// 绘制圆角矩形 Layer，a 点为左上角，b 为右上角，c 为右下角，d 为左下角
    class func roundedRect(size: CGSize, a: CGFloat, b: CGFloat, c: CGFloat, d: CGFloat) -> CAShapeLayer {
        let path = UIBezierPath()
        path.moveToPoint(CGPoint(x: 0, y: a))
        path.addArcWithCenter(CGPoint(x: a, y: a), radius: a, startAngle: CGFloat(M_PI), endAngle: CGFloat(M_PI_2) * 3, clockwise: true)
        path.addLineToPoint(CGPoint(x: size.width - b, y: 0))
        path.addArcWithCenter(CGPoint(x: size.width - b, y: b), radius: b, startAngle: CGFloat(M_PI_2) * 3, endAngle: CGFloat(M_PI_2) * 4, clockwise: true)
        path.addLineToPoint(CGPoint(x: size.width, y: size.height - c))
        path.addArcWithCenter(CGPoint(x: size.width - c, y: size.height - c), radius: c, startAngle: 0, endAngle: CGFloat(M_PI_2), clockwise: true)
        path.addLineToPoint(CGPoint(x: d, y: size.height))
        path.addArcWithCenter(CGPoint(x: d, y: size.height - d), radius: d, startAngle: CGFloat(M_PI_2), endAngle: CGFloat(M_PI), clockwise: true)
        path.closePath()
        
        let shape = CAShapeLayer()
        shape.path = path.CGPath
        return shape
    }
    
    /// 绘制直线
    class func line(frame: CGRect, x1: CGFloat, y1: CGFloat, x2: CGFloat, y2: CGFloat, w: CGFloat, dashPhase: CGFloat) -> CAShapeLayer {
        let path = UIBezierPath()
        path.moveToPoint(CGPoint(x: x1, y: y1))
        path.addLineToPoint(CGPoint(x: x2, y: y2))
        let shape = CAShapeLayer()
        shape.frame = frame
        shape.path  = path.CGPath
        shape.lineCap = kCALineCapRound
        shape.lineDashPhase = dashPhase
        shape.lineWidth = w
        return shape
    }

}
