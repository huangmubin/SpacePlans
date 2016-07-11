//
//  PlansController.swift
//  TimeLog
//
//  Created by 黄穆斌 on 16/7/11.
//  Copyright © 2016年 Myron. All rights reserved.
//

import UIKit

@objc protocol sss {
    weak var ddo: UIView? { get set }
}

class PlansController: UIViewController, TimeLogViewController {

    @IBOutlet var viewss: [sss]!
    
    // MARK: - TimeLogViewController
    
    var menuImage: UIImage!
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //menuView.animation(false)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func deploy() {
        deployMenuView()
    }
    
    // MARK: - Menu View
    
    @IBOutlet weak var menuView: MenuView!
    
    func deployMenuView() {
        menuView.image.image = menuImage
        menuView.addAction = { //[weak self] in
            
        }
        menuView.menuAction = { [weak self] (finish) in
            if finish {
                self?.navigationController?.popViewControllerAnimated(false)
            }
        }
    }
}
