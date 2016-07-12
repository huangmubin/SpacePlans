//
//  MenuView.swift
//  TimeLog
//
//  Created by 黄穆斌 on 16/7/12.
//  Copyright © 2016年 Myron. All rights reserved.
//

import UIKit

class MenuView: View {
    
    // MARK: - Values
    
    var open: ((String?) -> Void)?
    
    @IBOutlet weak var bottomLayout: NSLayoutConstraint!
    
    // MARK: - Methods
    
    @IBAction func openView(sender: Button) {
        open?(sender.note)
        push(false)
    }
    
    // MARK: - Animation
    
    func push(show: Bool) {
        userInteractionEnabled = show
        UIView.animateWithDuration(0.5) {
            self.bottomLayout.constant = show ? AppTint.Height : 44
            self.layoutIfNeeded()
        }
    }
    
    // MARK: - Gesture
    
    @IBAction func panGestureAction(sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .Began:
            break
        case .Changed:
            UIView.animateWithDuration(0.05) {
                self.bottomLayout.constant = AppTint.Height + sender.translationInView(self).y
                self.layoutIfNeeded()
            }
        case .Ended:
            let show = self.bottomLayout.constant >= AppTint.Height * 0.6
            if !show {
                open?(nil)
            }
            push(show)
        default:
            UIView.animateWithDuration(0.25) {
                self.bottomLayout.constant = AppTint.Height
                self.layoutIfNeeded()
            }
        }
    }
    
    
}
