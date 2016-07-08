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
    private var font = 0
    private var image = 0
    
    // MARK: - 色调
    
    /// 背景颜色
    class func backgroundColor() -> UIColor {
        return [
            UIColor.whiteColor()
        ][AppTint.shared.tint]
    }
    
    static let essentialColors: [UIColor] = [
        UIColor.blackColor()
    ]
    
    /// 主色调
    class func essentialColor() -> UIColor {
        return essentialColors[AppTint.shared.tint]
    }
    
    /// 按钮背景色 1
    class func buttonBackground1() -> UIColor {
        return [
            UIColor.whiteColor()
        ][AppTint.shared.tint]
    }
    class func buttonBackground2() -> UIColor {
        return [
            UIColor.whiteColor()
        ][AppTint.shared.tint]
    }
    class func buttonBackground3() -> UIColor {
        return [
            UIColor.whiteColor()
        ][AppTint.shared.tint]
    }
    
    /// 文本颜色
    class func textColor() -> UIColor {
        return [
            UIColor.blackColor()
        ][AppTint.shared.tint]
    }
    
    class func textDetailColor() -> UIColor {
        return [
            UIColor.grayColor()
        ][AppTint.shared.tint]
    }
    
    // MARK: - 字体
    
    /// 标题字体
    class func titleFont() -> UIFont {
        return [
            UIFont.systemFontOfSize(UIFont.systemFontSize() + 3)
        ][AppTint.shared.font]
    }
    
    /// 名字字体
    class func nameFont() -> UIFont {
        return [
            UIFont.systemFontOfSize(UIFont.systemFontSize())
        ][AppTint.shared.font]
    }
    
    /// 细节字体
    class func detailFont() -> UIFont {
        return [
            UIFont.systemFontOfSize(UIFont.systemFontSize() - 5)
        ][AppTint.shared.font]
    }
    
//    /// 按钮字体
//    class func buttonFont() -> UIFont {
//        return [
//            UIFont.systemFontOfSize(UIFont.systemFontSize())
//            ][AppTint.shared.font]
//    }
    
    // MARK: - 图片
    
    /// 图片后缀
    class func imageSuffix() -> String {
        return [
            ""
        ][AppTint.shared.image]
    }
}
