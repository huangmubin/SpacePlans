//
//  Botton.swift
//  TimeLog
//
//  Created by 黄穆斌 on 16/7/11.
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
        tintColor = AppTint.mainColor()
        setTitleColor(AppTint.backColor(), forState: .Selected)
    }

    // MARK: - Value
    
    enum Type: Int {
        case Text = 0
        case Image
        case Title
    }
    
    var type: Type = Type.Text
    @IBInspectable var types: Int = 0 {
        didSet {
            type = Type.init(rawValue: types) ?? Type.Text
        }
    }
    
    @IBInspectable var note: String = ""
    
    // MAKR: - Method
    
    func noteToImage() {
        setImage(UIImage(named: note), forState: .Normal)
    }
    
    func noteToTitle() {
        setTitle(note, forState: .Normal)
    }
    
    // MARK: - Override
    
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
    
    // MARK: - Draw
    
    override func drawRect(rect: CGRect) {
        switch type {
        case .Text:
            let path = UIBezierPath(roundedRect: rect, cornerRadius: 4)
            if selected {
                AppTint.mainColor().setFill()
            } else {
                AppTint.backColor().setFill()
            }
            path.fill()
            
            for image in subviews {
                if image is UIImageView {
                    image.hidden = true
                }
            }
        case .Image:
            break
        case .Title:
            return
        }
        
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 2
    }
}
