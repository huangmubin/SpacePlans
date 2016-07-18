//
//  EditorController.swift
//  TimeLog
//
//  Created by 黄穆斌 on 16/7/18.
//  Copyright © 2016年 Myron. All rights reserved.
//

import UIKit

class EditorController: UIViewController {
    
    class func initNib(nib: String, identifier: String) -> EditorController {
        return UIStoryboard(name: nib, bundle: nil).instantiateViewControllerWithIdentifier(identifier) as! EditorController
    }
    
    var index: DataIndex!
    
    var action: ((AnyObject?) -> Void)?
    
    func deploy() { }
    
    
}
