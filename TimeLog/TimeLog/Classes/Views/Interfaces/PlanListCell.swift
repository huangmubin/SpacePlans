//
//  PlanListCell.swift
//  TimeLog
//
//  Created by 黄穆斌 on 16/7/13.
//  Copyright © 2016年 Myron. All rights reserved.
//

import UIKit

class PlanListCell: UITableViewCell {

    // MARK: - Init
    
    override func awakeFromNib() {
        super.awakeFromNib()
        deploy()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }

    // MARK: - Values
    
    var index: NSIndexPath = NSIndexPath(forRow: 0, inSection: 0)
    
    // MARK: Layers
    
    var shadowLayer = CALayer()
    var backViewMaskLayer = CALayer()
    
    // MARK: Views
    
    @IBOutlet weak var backView: UIView!
    
    
    @IBOutlet weak var leftAView: UIView!
    @IBOutlet weak var leftBView: UIView!
    @IBOutlet weak var rightView: UIView!
    
    @IBOutlet weak var logButton: Button!
    @IBOutlet weak var timerButton: Button!
    @IBOutlet weak var editButton: Button!
    
    
    @IBOutlet weak var content: UIView!
    @IBOutlet weak var contentCenterLayout: NSLayoutConstraint!
    
    // MAKR: - Methods
    
    func deploy() {
        // shadowLayer
        shadowLayer.frame = CGRect(x: 8, y: 4, width: frame.width - 16, height: frame.height - 8)
        shadowLayer.cornerRadius    = 8
        shadowLayer.shadowOffset    = CGSizeZero
        shadowLayer.shadowOpacity   = 0.5
        shadowLayer.shadowRadius    = 2
        shadowLayer.backgroundColor = AppTint.backColor().CGColor
        layer.insertSublayer(shadowLayer, atIndex: 0)
        
        // backView
        backViewMaskLayer.cornerRadius = 8
        backViewMaskLayer.frame = backView.bounds
        backView.backgroundColor = AppTint.backColor()
        backView.layer.mask = backViewMaskLayer
        
        // Button View
        leftAView.backgroundColor = AppTint.subColor().A
        leftBView.backgroundColor = AppTint.subColor().B
        rightView.backgroundColor =
            AppTint.subColor().C
        
        // Content
        content.backgroundColor = AppTint.backColor()
        contentCenterLayout.constant = 0
        self.layoutIfNeeded()
    }
    
    // MARK: Button Actions
    
    var actions: ((String, NSIndexPath) -> Void)?
    
    @IBAction func buttonActions(sender: Button) {
        actions?(sender.note, index)
        UIView.animateWithDuration(0.5) {
            self.contentCenterLayout.constant = 0
            self.layoutIfNeeded()
        }
    }
    
    // MARK: Status
    
    func status(moving: Bool) {
        shadowLayer.opacity = moving ? 1 : 0.5
        shadowLayer.shadowRadius = moving ? 4 : 2
    }
    
    // MARK: - Gesture
    
    var origin: CGFloat = 0
    var layout: CGFloat = 0
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        origin = touches.first!.locationInView(self).y
        layout = contentCenterLayout.constant
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let distance = touches.first!.locationInView(self).y - origin
        UIView.animateWithDuration(0.02) { 
            self.contentCenterLayout.constant = self.layout + distance
            self.layoutIfNeeded()
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if self.contentCenterLayout.constant < -backView.frame.height {
            layout = -backView.frame.height
        } else if self.contentCenterLayout.constant > backView.frame.height {
            layout = backView.frame.height * 2
        } else {
            layout = 0
        }
        UIView.animateWithDuration(0.2) { 
            self.contentCenterLayout.constant = self.layout
            self.layoutIfNeeded()
        }
    }
    
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        UIView.animateWithDuration(0.2) { 
            self.contentCenterLayout.constant = 0
            self.layoutIfNeeded()
        }
    }
}
