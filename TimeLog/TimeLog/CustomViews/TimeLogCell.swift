//
//  TimeLogCell.swift
//  TimeLog
//
//  Created by 黄穆斌 on 16/7/17.
//  Copyright © 2016年 Myron. All rights reserved.
//

import UIKit

class TimeLogCell: UITableViewCell {

    // MARK: - Init
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    var singleDeploy = true
    func deploy() {
        guard singleDeploy else { return }
        singleDeploy = false
        
        self.layoutIfNeeded()
        
        // Button View
        leftViewA.backgroundColor = AppTint.subColor().A
        leftViewB.backgroundColor = AppTint.subColor().B
        rightView.backgroundColor = AppTint.subColor().C
        
        // Content
        containerView.backgroundColor = AppTint.backColor()
        //containerView.layer.cornerRadius = 4
        containerLayout.constant = 0
        self.layoutIfNeeded()
        
        // Label
        titleLabel.font  = AppTint.mainFont()
        rightLabel.font = AppTint.noteFont()
        leftLabel.font   = AppTint.noteFont()
        
        titleLabel.textColor  = AppTint.fontColor().main
        rightLabel.textColor = AppTint.fontColor().sub
        leftLabel.textColor   = AppTint.fontColor().sub
    }
    
    // MARK: - Type
    
    @IBInspectable var type: Int = 0
    var index: NSIndexPath!
    
    // MARK: - Views
    
    @IBOutlet weak var leftViewA: UIView!
    @IBOutlet weak var leftViewB: UIView!
    @IBOutlet weak var rightView: UIView!
    
    @IBOutlet weak var leftButtonA: Button!
    @IBOutlet weak var leftButtonB: Button!
    @IBOutlet weak var rightButton: Button!
    
    var actions: ((String, NSIndexPath) -> Void)?
    
    @IBAction func buttonActions(sender: Button) {
        actions?(sender.note, index)
        UIView.animateWithDuration(0.3) { 
            self.containerLayout.constant = 0
        }
    }
    
    // MARK: - Content
    
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var containerLayout: NSLayoutConstraint!
    
    // MARK: - Labels
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var rightLabel: UILabel!
    
    
    var gesture: ((Bool) -> Void)?
    var origin: CGFloat = 0
    var layout: CGFloat = 0
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        origin = touches.first!.locationInView(self).x
        layout = containerLayout.constant
        gesture?(false)
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        var distance = touches.first!.locationInView(self).x - origin + layout
        if type != 0 {
            distance = distance <= 0 ? distance : 0
        }
        UIView.animateWithDuration(0.02) {
            self.containerLayout.constant = self.layout + distance
            self.layoutIfNeeded()
        }
    }
    
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if self.containerLayout.constant < self.frame.height {
            layout = -self.frame.height
        } else if self.containerLayout.constant > self.frame.height {
            layout = self.frame.height * 2
        } else {
            layout = 0
        }
        UIView.animateWithDuration(0.2) {
            self.containerLayout.constant = self.layout
            self.layoutIfNeeded()
        }
        gesture?(true)
    }
    
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        UIView.animateWithDuration(0.2) {
            self.containerLayout.constant = 0
            self.layoutIfNeeded()
        }
        gesture?(true)
    }
    
}
