//
//  MenuCenterController.swift
//  TimeLog
//
//  Created by 黄穆斌 on 16/7/11.
//  Copyright © 2016年 Myron. All rights reserved.
//

import UIKit

class MenuCenterController: UITableViewController {
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        performSegue()
    }
    
    @IBOutlet weak var cell: UITableViewCell!
    
    // MARK: - Image
    var image = UIImage()
    func deployImage() {
        closeButton.hidden = true
        UIGraphicsBeginImageContext(cell.frame.size)
        let ctx = UIGraphicsGetCurrentContext()!
        cell.layer.renderInContext(ctx)
        image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        closeButton.hidden = false
    }
    
    // MARK: - Close
    
    @IBOutlet weak var closeButton: Button!
    @IBAction func closeAction(sender: Button) {
        performSegue()
    }
    
    
    // MARK: - Navigation
    
    var segue: String = "ShowPlans"
    var datas: AnyObject? = nil
    
    func performSegue() {
        performSegueWithIdentifier(segue, sender: datas)
    }
    
    @IBAction func performViews(sender: Button) {
        segue = sender.note
        performSegue()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        var controller = segue.destinationViewController as! TimeLogViewController
        controller.menuImage = image
    }
}
