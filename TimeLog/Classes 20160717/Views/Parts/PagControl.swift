//
//  PagControl.swift
//  TimeLog
//
//  Created by 黄穆斌 on 16/7/12.
//  Copyright © 2016年 Myron. All rights reserved.
//

import UIKit

class PageControl: UIPageControl {
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        deploy()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        deploy()
    }
    
    func deploy() {
        currentPageIndicatorTintColor = AppTint.mainColor()
        pageIndicatorTintColor = AppTint.subColor().A
        //addTarget(self, action: #selector(valueChanged), forControlEvents: .ValueChanged)
    }
    
//    // MARK: - Methods
//    
//    var changed: ((Int) -> Void)?
//    
//    // MARK: Action
//    
//    func valueChanged() {
//        changed?(currentPage)
//    }
}
