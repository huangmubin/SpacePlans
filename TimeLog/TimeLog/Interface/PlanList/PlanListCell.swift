//
//  MenuCell.swift
//  TimeLog
//
//  Created by 黄穆斌 on 16/7/7.
//  Copyright © 2016年 Myron. All rights reserved.
//

import UIKit

class PlanListCell: UITableViewCell {

    // MARK: - Awake
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layoutIfNeeded()
        //drawShadow()
        drawBackground()
        drawButton()
        drawContainer()
        drawLabel()
        //print("shadow \(shadow.frame); timer \(timerBackground.frame)")
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    @IBOutlet weak var background: UIView!
    func drawBackground() {
        background.layer.cornerRadius = 4
        background.layer.masksToBounds = true
    }
    
    // MARK: - Shadow
    
    let shadow = CALayer()
    func drawShadow() {
        shadow.frame = background.frame
        shadow.backgroundColor = AppTint.backgroundColor().CGColor
        shadow.shadowOpacity   = 0.5
        shadow.shadowOffset    = CGSize(width: 0, height: 0)
        shadow.shadowRadius    = 2
        shadow.cornerRadius    = 4
        layer.insertSublayer(shadow, atIndex: 0)
    }
    
    func heightLightShadow(light: Bool) {
        shadow.shadowOpacity = light ? 1 : 0.5
        shadow.shadowOffset  = light ? CGSize(width: 1, height: 1) : CGSizeZero
    }
    
    // MARK: - Button Background
    
    @IBOutlet weak var logBackground: UIView!
    @IBOutlet weak var timerBackground: UIView!
    @IBOutlet weak var editBackground: UIView!
    
    @IBOutlet weak var logButton: UIButton!
    @IBOutlet weak var timerButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    
    @IBOutlet weak var logWidth: NSLayoutConstraint!
    @IBOutlet weak var timerWidth: NSLayoutConstraint!
    @IBOutlet weak var editWidth: NSLayoutConstraint!
    
    func drawButton() {
        let subffix = AppTint.imageSuffix()
        logButton.setImage(UIImage(named: "LogAdd" + subffix), forState: .Normal)
        timerButton.setImage(UIImage(named: "Timer" + subffix), forState: .Normal)
        editButton.setImage(UIImage(named: "Edit" + subffix), forState: .Normal)
        
        logBackground.backgroundColor = AppTint.buttonBackground1()
        timerBackground.backgroundColor = AppTint.buttonBackground2()
        editBackground.backgroundColor = AppTint.buttonBackground3()
    }
    
    // MARK: - Container
    
    @IBOutlet weak var container: UIView!
    @IBOutlet weak var containerCenter: NSLayoutConstraint!
    
    func drawContainer() {
        container.layer.cornerRadius = 4
        container.layer.backgroundColor = AppTint.backgroundColor().CGColor
    }
    
    // MARK: - Label
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var allLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    
    func drawLabel() {
        nameLabel.font = AppTint.nameFont()
        allLabel.font = AppTint.detailFont()
        dayLabel.font = AppTint.detailFont()
    }
    
    func updateLabel(idle: Bool) {
        nameLabel.textColor = idle ? AppTint.textDetailColor() : AppTint.textColor()
        allLabel.textColor  = AppTint.textDetailColor()
        dayLabel.textColor  = AppTint.textDetailColor()
    }
    
    // MARK: - Touch
    var began = CGPointZero
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        began = touches.first!.locationInView(self)
        began.x -= containerCenter.constant
        //drawShadow()
    }
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        guard let move = touches.first?.locationInView(self) else { return }
        let lenght = self.touchLenght(move.x)
        UIView.animateWithDuration(0.02) {
            self.containerCenter.constant = lenght
            self.logWidth.constant = abs(lenght) / 2
            self.timerWidth.constant = abs(lenght) / 2
            self.editWidth.constant = abs(lenght)
            self.layoutIfNeeded()
        }
    }
    override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
        guard let end = touches.first?.locationInView(self) else { return }
        let lenght = touchLenght(end.x)
        var constant: CGFloat = 0
        if lenght >= background.frame.height {
            constant = background.frame.height * 2
        } else if lenght <= -background.frame.height {
            constant = -background.frame.height
        }
        UIView.animateWithDuration(0.5) { 
            self.containerCenter.constant = constant
            self.logWidth.constant = abs(constant) / 2
            self.timerWidth.constant = abs(constant) / 2
            self.editWidth.constant = abs(constant)
            self.layoutIfNeeded()
        }
        //print("shadow \(shadow.frame); timer \(timerBackground.frame)")
    }
    override func touchesCancelled(touches: Set<UITouch>?, withEvent event: UIEvent?) {
        UIView.animateWithDuration(0.5) {
            self.containerCenter.constant = 0
            self.logWidth.constant = 0
            self.timerWidth.constant = 0
            self.editWidth.constant = 0
            self.layoutIfNeeded()
        }
    }
    
    func touchLenght(move: CGFloat) -> CGFloat {
        var lenght = abs(move - began.x)
        let out = Double(lenght / frame.width)
        lenght -= lenght * CGFloat(sin(out * M_PI_2)) / 2
        lenght *= move > began.x ? 1 : -1
        return lenght
    }
}
