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
    
    var menuAction: ((UIButton?) -> Void)?
    var addAction: ((UIButton?) -> Void)?
    
    @IBAction func menuButtonAction(sender: UIButton) {
        menuAction?(sender)
    }
    @IBAction func addButtonAction(sender: UIButton) {
        addAction?(sender)
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
    
    func deploy() {
        //
        backgroundColor = UIColor.clearColor()
        let shape = LayerDrawer.roundedRect(frame.size, a: 0, b: 0, c: 8, d: 8)
        shape.frame = CGRect(origin: CGPointZero, size: frame.size)
        shape.fillColor = AppTint.backgroundColor().CGColor
        shape.shadowOffset = CGSize(width: 0, height: 2)
        shape.shadowOpacity = 0.5
        layer.insertSublayer(shape, atIndex: 0)
        
        //
        titleLabel?.font = AppTint.titleFont()
        titleLabel?.textColor = AppTint.textColor()
        
        menuButton?.setImage(UIImage(named: "MenuOpen" + AppTint.imageSuffix()), forState: .Normal)
        addButton?.setImage(UIImage(named: "PlanAdd" + AppTint.imageSuffix()), forState: .Normal)
    }
    
}
