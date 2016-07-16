//
//  Notify.swift
//  TimeLog
//
//  Created by 黄穆斌 on 16/7/13.
//  Copyright © 2016年 Myron. All rights reserved.
//

import UIKit

enum NotifyType: String {
//    case ReloadIdle = "ReloadIdle"
//    case ReloadPlan = "ReloadPlan"
//    case UpdateIdle = "UpdateIdle"
//    case UpdatePlan = "UpdatePlan"
    case Reload = "Reload"
    case Update = "Update"
}

class Notify: NSObject {
    
    // MAKR: - Methods
    
    // MARK: Add
    
    class func add(observer: AnyObject, selector: Selector, type: NotifyType, object: AnyObject?) {
        NSNotificationCenter.defaultCenter().addObserver(observer, selector: selector, name: type.rawValue, object: object)
    }
    
    class func add(observer: AnyObject, selector: Selector, type: NotifyType) {
        NSNotificationCenter.defaultCenter().addObserver(observer, selector: selector, name: type.rawValue, object: nil)
    }
    
    // MARK: Remove
    
    class func remove(observer: AnyObject, type: NotifyType, object: AnyObject?) {
        NSNotificationCenter.defaultCenter().removeObserver(observer, name: type.rawValue, object: object)
    }
    
    class func remove(observer: AnyObject) {
        NSNotificationCenter.defaultCenter().removeObserver(observer)
    }
    
    // MARK: Post
    
    class func post(type: NotifyType, object: AnyObject?, userInfo: [NSObject : AnyObject]?) {
        NSNotificationCenter.defaultCenter().postNotificationName(type.rawValue, object: object, userInfo: userInfo)
    }
    
    class func post(type: NotifyType, userInfo: [NSObject : AnyObject]?) {
        NSNotificationCenter.defaultCenter().postNotificationName(type.rawValue, object: nil, userInfo: userInfo)
    }
    
    class func post(type: NotifyType, info: AnyObject) {
        NSNotificationCenter.defaultCenter().postNotificationName(type.rawValue, object: nil, userInfo: ["Data": info])
    }
    
    class func post(type: NotifyType) {
        NSNotificationCenter.defaultCenter().postNotificationName(type.rawValue, object: nil, userInfo: nil)
    }
    
    // MARK: - Data
    
    class func data(notify: NSNotification) -> AnyObject? {
        if let info = notify.userInfo {
            return info["Data"]
        }
        return nil
    }
    class func data(notify: NSNotification, key: NSObject) -> AnyObject? {
        if let info = notify.userInfo {
            return info[key]
        }
        return nil
    }
}
