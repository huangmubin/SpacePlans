//
//  ViewController.swift
//  TimeLog
//
//  Created by 黄穆斌 on 16/7/17.
//  Copyright © 2016年 Myron. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    class func initNib(nib: String) -> ViewController {
        return UIStoryboard(name: nib, bundle: nil).instantiateViewControllerWithIdentifier(nib + "Controller") as! ViewController
    }
    
    
    class func initNib(nib: String, identifier: String) -> ViewController {
        return UIStoryboard(name: nib, bundle: nil).instantiateViewControllerWithIdentifier(identifier) as! ViewController
    }
    
    func deploy() {
        
    }
    
    func update(data: AnyObject?) {
        
    }
    
    var actions: ((AnyObject?) -> Void)?
    
    deinit {
        print("\(self) - Deinit.")
    }
}
