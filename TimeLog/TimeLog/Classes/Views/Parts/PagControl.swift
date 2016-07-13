//
//  PagControl.swift
//  TimeLog
//
//  Created by 黄穆斌 on 16/7/12.
//  Copyright © 2016年 Myron. All rights reserved.
//

import UIKit

class PagControl: UIView {

    func deploy() {
        let y = frame.height / 2
        
        // 按钮
        leftButton.setImage(leftImage, forState: .Normal)
        rightButton.setImage(rightImage, forState: .Normal)
        
        leftButton.frame.origin  = CGPoint(x: 0, y: y - 15)
        rightButton.frame.origin = CGPoint(x: frame.width - 30, y: y - 15)
        
        leftButton.addTarget(self, action: #selector(buttonAction), forControlEvents: UIControlEvents.TouchUpInside)
        rightButton.addTarget(self, action: #selector(buttonAction), forControlEvents: UIControlEvents.TouchUpInside)
        
        addSubview(leftButton)
        addSubview(rightButton)
        
        // Background
        backLayer.frame = CGRect(x: 30, y: y - 15, width: frame.width - 60, height: 30)
        backLayer.backgroundColor = UIColor.redColor().CGColor
        backLayer.masksToBounds = true
        layer.insertSublayer(backLayer, atIndex: 0)
        
        // Points
        let w = (size + space) * CGFloat(total) + space
        pointsLayer.frame = CGRect(x: 0, y: 0, width: w, height: 30)
        for i in 0 ..< total {
            let sub = Drawer.round(size)
            sub.position = CGPoint(x: CGFloat(i) * (size + space) + space + size / 2, y: 15)
            sub.backgroundColor = subColor.CGColor
            pointsLayer.addSublayer(sub)
        }
        origin = pointsLayer.frame.width / 2 - space - size / 2 + backLayer.frame.width / 2
        pointsLayer.position = CGPoint(x: origin - CGFloat(index) * (size + space), y: y)
        backLayer.addSublayer(pointsLayer)
        
        // Center
        centerLayer = Drawer.round(size)
        centerLayer.backgroundColor = color.CGColor
        centerLayer.position = CGPoint(x: backLayer.frame.width / 2, y: 10)
        backLayer.addSublayer(centerLayer)
    }
    
    
    // MARK: - Values
    
    // MARK: Layer
    
    var origin: CGFloat = 0
    var backLayer = CALayer()
    var pointsLayer = CALayer()
    var centerLayer = CALayer()
    
    // MARK: Button
    
    /// 左边按钮
    var leftButton = ImageButton()
    /// 右边按钮
    var rightButton = ImageButton()
    
    /// 左边按钮图片
    var leftImage = UIImage(named: "PagControlLeft")
    /// 右边按钮图片
    var rightImage = UIImage(named: "PagControlRight")
    
    // MARK: Points
    
    /// 当前圆点位置
    var index: Int = 0
    /// 总共圆点个数
    var total: Int = 5
    
    /// 圆点大小
    var size: CGFloat = 8
    /// 圆点之间距离
    var space: CGFloat = 12
    
    /// 圆点颜色
    var color: UIColor = AppTint.accentColor()
    /// 暗色
    var subColor: UIColor = AppTint.subColor().A
    
    // MARK: - Actions
    
    // MARK: Output
    
    var indexChanged: ((Bool, Int) -> Void)?
    
    // MARK: Private
    
    func buttonAction(sender: ImageButton) {
        CATransaction.begin()
        CATransaction.setAnimationDuration(2)
        CATransaction.setCompletionBlock {
            CATransaction.begin()
            CATransaction.setAnimationDuration(2)
            CATransaction.setCompletionBlock {
                print("Done")
            }
            self.centerLayer.position = CGPoint(x: self.backLayer.frame.width / 2, y: 15)
            CATransaction.commit()
        }
        self.centerLayer.position = CGPoint(x: 0, y: 15)
        CATransaction.commit()
//        switch (sender === leftButton, index > 0, index < total-1) {
//        case (true, true, _):
//            index -= 1
//            indexChanged?(true, index)
//        case (false, _, true):
//            index += 1
//            indexChanged?(true, index)
//        default:
//            indexChanged?(false, index)
//        }
    }
    
    // MARK: - Animation
    
    func changeIndexAnimation() {
        
    }
    
    // MARK: - Draw
    
}

class ImageButton: UIButton {
    
    init() {
        super.init(frame: CGRect(origin: CGPointZero, size: CGSize(width: 30, height: 30)))
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override var highlighted: Bool {
        didSet {
            if highlighted {
                self.alpha = 0.2
            } else {
                UIView.animateWithDuration(0.5) {
                    self.alpha = 1
                }
            }
        }
    }
}
