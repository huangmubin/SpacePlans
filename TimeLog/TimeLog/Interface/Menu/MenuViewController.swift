//
//  MenuViewController.swift
//  TimeLog
//
//  Created by 黄穆斌 on 16/7/7.
//  Copyright © 2016年 Myron. All rights reserved.
//

import UIKit

class MenuViewController: UITableViewController {

    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        drawBackground()
        deployTint()
        performSegueWithIdentifier(showController, sender: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        print(segue.identifier)
        let con = segue.destinationViewController as! PlanListViewController
        con.aa = "yes"
    }
    
    func deployTint() {
        deployBackground()
        deployClose()
        deployButtons()
        deployColors()
        deployLike()
        deployChat()
    }
    
    // MARK: Navigation
    
    var showController = "ShowPlanList"
    
    // MARK: Background
    
    @IBOutlet weak var contentCell: UITableViewCell!
    var lines = [CAShapeLayer]()
    func drawBackground() {
        let x: (CGFloat, CGFloat) = (20, AppTint.Width - 20)
        let ys: [CGFloat] = [60,245]
        let frame = UIScreen.mainScreen().bounds
        for y in ys {
            let shape = LayerDrawer.line(frame, x1: x.0, y1: y, x2: x.1, y2: y, w: 1, dashPhase: 0)
            shape.strokeColor = AppTint.essentialColor().CGColor
            shape.shadowOpacity = 0.5
            shape.shadowOffset = CGSizeZero
            contentCell.layer.insertSublayer(shape, atIndex: 0)
            lines.append(shape)
        }
    }
    
    func deployBackground() {
        tableView.backgroundColor = AppTint.backgroundColor()
        contentCell.backgroundColor = AppTint.backgroundColor()
        lines.forEach {
            $0.strokeColor = AppTint.essentialColor().CGColor
            $0.setNeedsDisplay()
        }
    }
    
    // MARK: - Close
    
    @IBOutlet weak var closeButton: Button!
    
    func deployClose() {
        colorButton.setImage(UIImage(named: "MenuClose" + AppTint.imageSuffix()), forState: .Normal)
    }
    
    @IBAction func closeAction(sender: Button) {
        UIView.animateWithDuration(0.2, animations: {
            self.contentCell.alpha = 0
            }) { (finish) in
            //self.dismissViewControllerAnimated(false, completion: nil)
            self.performSegueWithIdentifier(self.showController, sender: nil)
        }
    }
    
    // MARK: - Buttons
    
    @IBOutlet var viewButtons: [Button]!
    
    func deployButtons() {
        for button in viewButtons {
            button.titleLabel?.font = AppTint.titleFont()
            button.deploy()
            button.setNeedsDisplay()
        }
    }
    
    @IBAction func planListAction(sender: Button) {
    }
    @IBAction func logListAction(sender: Button) {
    }
    @IBAction func dayChartAction(sender: Button) {
    }
    @IBAction func timerAction(sender: Button) {
    }
    
    
    // MARK: - Color
    
    @IBOutlet weak var colorImage: UIImageView!
    @IBOutlet weak var colorTitle: UILabel!
    
    @IBOutlet weak var colorButton: Button!
    @IBOutlet var colorButtons: [Button]!
    
    func deployColors() {
        // Title
        colorImage.image = UIImage(named: "Colors" + AppTint.imageSuffix())
        colorTitle.textColor = AppTint.textColor()
        
        // Button
        colorButton.typeNumber = AppTint.shared.tint + 10
        colorButtons.forEach {
            $0.deploy()
            $0.setNeedsDisplay()
        }
    }
    
    @IBAction func colorAction(sender: UIButton) {
        for i in 0 ..< 3 {
            if colorButtons[i] === sender && i != AppTint.shared.tint {
                AppTint.shared.tint = i
                colorButton.typeNumber = i + 10
                deployTint()
            }
        }
    }
    
    // MARK: - Like
    
    @IBOutlet weak var likeImage: UIImageView!
    @IBOutlet weak var likeLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    
    func deployLike() {
        likeImage.image = UIImage(named: "Like" + AppTint.imageSuffix())
        likeButton.setImage(UIImage(named: "More" + AppTint.imageSuffix()), forState: .Normal)
        likeLabel.textColor = AppTint.textColor()
    }
    
    @IBAction func likeAction(sender: UIButton) {
    }
    
    // MARK: - Chat
    
    @IBOutlet weak var chatImage: UIImageView!
    @IBOutlet weak var chatLabel: UILabel!
    @IBOutlet weak var chatButton: UIButton!
    
    func deployChat() {
        chatImage.image = UIImage(named: "Chat" + AppTint.imageSuffix())
        chatButton.setImage(UIImage(named: "More" + AppTint.imageSuffix()), forState: .Normal)
        chatLabel.textColor = AppTint.textColor()
    }
    @IBAction func chartAction(sender: UIButton) {
    }
}
