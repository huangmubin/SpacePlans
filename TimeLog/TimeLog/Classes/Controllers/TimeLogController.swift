//
//  TimeLogController.swift
//  TimeLog
//
//  Created by 黄穆斌 on 16/7/11.
//  Copyright © 2016年 Myron. All rights reserved.
//

import UIKit

class TimeLogController: UIViewController {

    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        deployMenuView()
        deployMenuBar()
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        menuView.setNeedsDisplay()
        pag.deploy()
    }
    @IBOutlet weak var pag: PagControl!
    
    // MARK: - Views
    
    // MARK: Menu View
    @IBOutlet weak var menuView: MenuView!
    
    func deployMenuView() {
        menuView.open = { [weak self] in
            if let action = $0 {
                print(action)
            }
            self?.menuBar.leftAnimation("MenuOpen")
        }
    }
    
    // MARK: Menu Bar
    @IBOutlet weak var menuBar: MenuBar!
    
    func deployMenuBar() {
        menuBar.deploy()
        menuBar.leftAction = { [weak self] in
            self?.menuView.push($0)
        }
        menuBar.rightAction = {
            print($0)
        }
        menuBar.planListAction = {
            print($0)
        }
    }
    
    // MARK: - Navigation
     
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
    }

}
