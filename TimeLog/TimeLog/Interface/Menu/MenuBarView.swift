//
//  MenuBarView.swift
//  TimeLog
//
//  Created by 黄穆斌 on 16/7/7.
//  Copyright © 2016年 Myron. All rights reserved.
//

import UIKit

final class MenuBarView: UIView {

    // MARK: Property
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var menuButton: UIButton!
    @IBOutlet weak var addButton: UIButton!
    
    // MARK: Value
    
    var menuAction: ((Bool) -> Void)?
    var addAction: (() -> Void)?
    //var completed: ((Bool) -> Void)?
    var pushed: Bool {
        return rectLayer.bounds.height > 0
    }
    
    @IBAction func menuButtonAction(sender: UIButton) {
        animation(!pushed)
    }
    @IBAction func addButtonAction(sender: UIButton) {
        addAction?()
    }
    
    // MARK: Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        deploy()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        deploy()
    }
    
    
    var roundLayer: CAShapeLayer!
    let rectLayer = CALayer()
    func deploy() {
        backgroundColor = UIColor.clearColor()
        
        // 填充视图
        rectLayer.frame = CGRect(x: 0, y: 0, width: frame.width, height: 0)
        rectLayer.backgroundColor = AppTint.backgroundColor().CGColor
        layer.insertSublayer(rectLayer, atIndex: 0)
        
        // 圆角视图
        roundLayer = LayerDrawer.roundedRect(frame.size, a: 0, b: 0, c: 8, d: 8)
        roundLayer.frame = CGRect(origin: CGPointZero, size: frame.size)
        roundLayer.fillColor = AppTint.backgroundColor().CGColor
        roundLayer.shadowOffset = CGSize(width: 0, height: 2)
        roundLayer.shadowOpacity = 0.5
        layer.insertSublayer(roundLayer, atIndex: 0)
        
        // 标题
        titleLabel?.font = AppTint.titleFont()
        titleLabel?.textColor = AppTint.textColor()
        
        // 按钮
        menuButton?.setImage(UIImage(named: "MenuOpen" + AppTint.imageSuffix()), forState: .Normal)
        addButton?.setImage(UIImage(named: "PlanAdd" + AppTint.imageSuffix()), forState: .Normal)
    }
    
    // MARK: - Animation
    
    func animation(push: Bool) {
        // Layer
        CATransaction.begin()
        CATransaction.setAnimationDuration(0.5)
        roundLayer.position = CGPoint(x: frame.width / 2, y: (push ? AppTint.Height - frame.height : 0) + frame.height / 2)
        rectLayer.frame = CGRect(x: 0, y: 0, width: frame.width, height: push ? AppTint.Height - frame.height : 0)
        CATransaction.commit()
        
        // Button
        animation1(push)
    }
    
    func animation1(push: Bool) {
        UIView.animateWithDuration(0.25, animations: {
            self.menuButton.alpha = 0
            }) { (finish) in
                self.animation2(push)
        }
        UIView.animateWithDuration(0.5) {
            self.addButton.alpha = push ? 0 : 1
            self.titleLabel.alpha = push ? 0 : 1
        }
    }
    
    func animation2(push: Bool) {
        self.menuButton.setImage(UIImage(named: (push ? "MenuClose" : "MenuOpen") + AppTint.imageSuffix()), forState: .Normal)
        UIView.animateWithDuration(0.25, animations: {
            self.menuButton.alpha = 1
            }) { (finish) in
                self.menuAction?(push)
        }
    }
}
