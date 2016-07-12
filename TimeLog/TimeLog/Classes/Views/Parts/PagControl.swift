//
//  PagControl.swift
//  TimeLog
//
//  Created by 黄穆斌 on 16/7/12.
//  Copyright © 2016年 Myron. All rights reserved.
//

import UIKit

class PagControl: UIView {

    // MARK: - Values
    
    // MARK: Button
    /// 左边按钮
    var leftButton = UIButton()
    /// 右边按钮
    var rightButton = UIButton()
    /// 左边按钮图片
    var leftImage = UIImage()
    /// 右边按钮图片
    var rightImage = UIImage()
    
    // MARK: Points
    /// 当前圆点位置
    var index: Int = 0
    /// 总共圆点个数
    var total: Int = 5
    /// 最大显示圆点数量
    var max: Int = 5
    
    /// 圆点大小
    var size: CGFloat = 2
    /// 圆点之间距离
    var space: CGFloat = 5
    
    /// 圆点颜色
    var color: UIColor = AppTint.accentColor()
    /// 暗色
    var subColor: UIColor = AppTint.subColor().A
    
    // MARK: - Actions
    
    // MARK: - Draw
    
    // MARK: - Animation
}
