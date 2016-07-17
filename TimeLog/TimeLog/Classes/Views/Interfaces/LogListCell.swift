//
//  LogListCell.swift
//  TimeLog
//
//  Created by 黄穆斌 on 16/7/16.
//  Copyright © 2016年 Myron. All rights reserved.
//

import UIKit

class LogListCell: UITableViewCell {
    
    // MARK: - Values
    
    var index: NSIndexPath = NSIndexPath(forRow: 0, inSection: 0)
    
    // MARK: Layers
    
    var shadowLayer = CALayer()
    var backViewMaskLayer = CALayer()
    
    // MARK: Views
    
    @IBOutlet weak var backView: UIView!
    
    @IBOutlet weak var rightView: UIView!
    
    @IBOutlet weak var deleteButton: Button!
    
    @IBOutlet weak var content: UIView!
    @IBOutlet weak var contentCenterLayout: NSLayoutConstraint!
    
    @IBOutlet weak var noteLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var startLabel: UILabel!

    
    // MAKR: - Methods
    
    var singleDeploy = true
    func deploy() {
        guard singleDeploy else { return }
        singleDeploy = false
        
        self.layoutIfNeeded()
        // shadowLayer
        //shadowLayer.frame = CGRect(x: 8, y: 4, width: frame.width - 16, height: frame.height - 8)
        shadowLayer.frame = backView.frame
        shadowLayer.cornerRadius    = 4
        shadowLayer.shadowOffset    = CGSizeZero
        shadowLayer.shadowOpacity   = 0.5
        shadowLayer.shadowRadius    = 2
        shadowLayer.backgroundColor = AppTint.backColor().CGColor
        layer.insertSublayer(shadowLayer, atIndex: 0)
        
        // backView
        backViewMaskLayer.cornerRadius = 4
        backViewMaskLayer.backgroundColor = UIColor.whiteColor().CGColor
        backViewMaskLayer.frame  = backView.bounds
        backView.backgroundColor = AppTint.backColor()
        backView.layer.masksToBounds = true
        backView.layer.mask = backViewMaskLayer
        
        // Button View
        rightView.backgroundColor = AppTint.subColor().C
        
        // Content
        content.backgroundColor = AppTint.backColor()
        content.layer.cornerRadius = 4
        contentCenterLayout.constant = 0
        self.layoutIfNeeded()
        
        // Label
        noteLabel.font  = AppTint.mainFont()
        timeLabel.font = AppTint.noteFont()
        startLabel.font   = AppTint.noteFont()
        
        noteLabel.textColor  = AppTint.fontColor().main
        timeLabel.textColor = AppTint.fontColor().sub
        startLabel.textColor   = AppTint.fontColor().sub
    }
    
    
    
    // MARK: Button Actions
    
    var actions: ((NSIndexPath) -> Void)?
    
    @IBAction func buttonActions(sender: Button) {
        actions?(index)
        UIView.animateWithDuration(0.5) {
            self.contentCenterLayout.constant = 0
            self.layoutIfNeeded()
        }
    }
    
    
    // MARK: - Gesture
    
    var gesture: ((Bool) -> Void)?
    var origin: CGFloat = 0
    var layout: CGFloat = 0
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        origin = touches.first!.locationInView(self).x
        layout = contentCenterLayout.constant
        gesture?(true)
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let distance = touches.first!.locationInView(self).x - origin + self.layout
        UIView.animateWithDuration(0.02) {
            self.contentCenterLayout.constant = distance <= 0 ? distance : 0
            self.layoutIfNeeded()
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if self.contentCenterLayout.constant < -backView.frame.height {
            layout = -backView.frame.height
        } else {
            layout = 0
        }
        UIView.animateWithDuration(0.2) {
            self.contentCenterLayout.constant = self.layout
            self.layoutIfNeeded()
        }
        gesture?(false)
    }
    
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        UIView.animateWithDuration(0.2) {
            self.contentCenterLayout.constant = 0
            self.layoutIfNeeded()
        }
        gesture?(false)
    }
    
}
