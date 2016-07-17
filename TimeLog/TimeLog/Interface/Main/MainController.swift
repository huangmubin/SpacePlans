//
//  MainController.swift
//  TimeLog
//
//  Created by 黄穆斌 on 16/7/17.
//  Copyright © 2016年 Myron. All rights reserved.
//

import UIKit

// MAKR: - Struct And Enum

struct ControllerShowing {
    var type = ControllerType.Plan {
        didSet {
            if type != .Menu {
                befor = type
            }
        }
    }
    var befor = ControllerType.Plan {
        didSet {
            NSUserDefaults.standardUserDefaults().setObject(befor.rawValue, forKey: "ControllerType")
        }
    }
    
    func createType() -> ViewController {
        return ViewController.initNib(type.rawValue)
    }
    
    func createBefor() -> ViewController {
        return ViewController.initNib(befor.rawValue)
    }
    
    mutating func deploy() {
        let str = NSUserDefaults.standardUserDefaults().objectForKey("ControllerType") as? String
        type = ControllerType(rawValue: str ?? "Plan")!
    }
}

enum ControllerType: String {
    case Menu = "Menu"
    case Plan = "Plan"
    case Log  = "Log"
    case Day  = "Day"
    case Timer = "Timer"
}

// MARK: - MainController

class MainController: UIViewController {

    // MARK: - Values
    
    var type = ControllerShowing()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        type.deploy()
        didShowController = type.createType()
        view.addSubview(didShowController.view)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    // MARK: - Showing
    
    var didShowController: ViewController!
    var willShowController: ViewController!
    
    
}
