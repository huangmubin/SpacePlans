//
//  AppTint.swift
//  TimeLog
//
//  Created by 黄穆斌 on 16/7/11.
//  Copyright © 2016年 Myron. All rights reserved.
//

import UIKit

/// 状态栏高度
let StatusBarHeight = UIApplication.sharedApplication().statusBarFrame.height
/// 屏幕宽度
let ScreenWidth     = UIScreen.mainScreen().bounds.width
/// 屏幕高度
let ScreenHeight    = UIScreen.mainScreen().bounds.height
/// 视图尺寸
let ViewFrame       = CGRect(x: 0, y: StatusBarHeight, width: ScreenWidth, height: ScreenHeight - StatusBarHeight - 4)


class AppTint: NSObject {
    
    // MARK: - Values
    
//    static let Width = UIScreen.mainScreen().bounds.width
//    static let Height = UIScreen.mainScreen().bounds.height
//    static let Size = CGSize(width: UIScreen.mainScreen().bounds.width, height: UIScreen.mainScreen().bounds.height)
    
    // MARK: - Colors
    
    class func backColor() -> UIColor {
        return UIColor.whiteColor()
    }
    
    class func mainColor() -> UIColor {
        return UIColor.blackColor()
    }
    
    class func subColor() -> (A: UIColor, B: UIColor, C: UIColor) {
        return (
            UIColor.darkGrayColor(),
            UIColor.grayColor(),
            UIColor.lightGrayColor()
        )
    }
    
    class func accentColor() -> UIColor {
        return UIColor.whiteColor()
    }
    
    // MARK: - Fonts
    
    class func fontColor() -> (main: UIColor, sub: UIColor, accent: UIColor) {
        return (
            UIColor.darkTextColor(),
            UIColor.lightGrayColor(),
            UIColor.whiteColor()
        )
    }
    
    class func mainFont() -> UIFont {
        return UIFont.systemFontOfSize(UIFont.systemFontSize())
    }
    
    class func titleFont() -> UIFont {
        return UIFont.systemFontOfSize(UIFont.systemFontSize() + 5)
    }
    
    class func noteFont() -> UIFont {
        return UIFont.systemFontOfSize(UIFont.systemFontSize() - 5)
    }
    
}
