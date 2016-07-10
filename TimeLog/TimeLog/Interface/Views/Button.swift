//
//  Button.swift
//  TimeLog
//
//  Created by 黄穆斌 on 16/7/8.
//  Copyright © 2016年 Myron. All rights reserved.
//

import UIKit


//@IBDesignable
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
    
    // MARK: - Override
    
//    override var selected: Bool {
//        didSet {
//            for image in subviews {
//                if image is UIImageView  {
//                    image.hidden = true
//                }
//            }
//        }
//    }
    
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
    
    // MARK: - Type
    
    enum Type {
        case Text
        case Image
        case Color(UIColor)
    }
    
    /// 定义类型和颜色 0: Text; 1: Image; 10: AppTint.tintColors[0]; 11: AppTint.tintColors[1]; 12: AppTint.tintColors[2];
    @IBInspectable var typeNumber: Int = 0 {
        didSet {
            switch typeNumber {
            case 0:
                type = Type.Text
            case 1:
                type = Type.Image
            case 10:
                type = Type.Color(AppTint.tintColors[0])
            case 11:
                type = Type.Color(AppTint.tintColors[1])
            case 12:
                type = Type.Color(AppTint.tintColors[2])
            default:
                break
            }
            setNeedsDisplay()
        }
    }
    
    var type: Type = Type.Text
    
    // MARK: - Draw
    
    override func drawRect(rect: CGRect) {
        let path = UIBezierPath(roundedRect: rect, cornerRadius: 4)
        switch type {
        case .Text:
            if selected {
                AppTint.essentialColor().setFill()
            } else {
                AppTint.backgroundColor().setFill()
            }
            path.fill()
        case .Color(let color):
            color.setFill()
            path.fill()
        case .Image:
            break
        }
        
        switch type {
        case .Image:
            break
        default:
            for image in subviews {
                if image is UIImageView {
                    image.hidden = true
                }
            }
        }
        
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowRadius = 2
    }
    
}
