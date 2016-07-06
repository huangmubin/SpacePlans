//
//  AppTint.swift
//  TimeLog
//
//  Created by 黄穆斌 on 16/7/7.
//  Copyright © 2016年 Myron. All rights reserved.
//

import UIKit

class AppTint {

    // MARK: - 全局绘图数据
    static let Height = UIScreen.mainScreen().bounds.height
    static let Width  = UIScreen.mainScreen().bounds.width
    
    // MARK: - 单例
    static let shared = AppTint()
    private init() { }
    class func deploy() { }
    
    // MARK: - 属性
    private var tint = 0
    
    // MARK: - 色调
    
    /// 背景颜色
    class func backgroundColor() -> UIColor {
        return [
            UIColor.whiteColor()
        ][AppTint.shared.tint]
    }
    
    /// 主色调
    class func essentialColor() -> UIColor {
        return [
            UIColor.blackColor()
        ][AppTint.shared.tint]
    }
    
}
