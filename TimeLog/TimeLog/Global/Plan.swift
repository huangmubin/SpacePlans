//
//  Plan.swift
//  TimeLog
//
//  Created by 黄穆斌 on 16/7/11.
//  Copyright © 2016年 Myron. All rights reserved.
//

import Foundation
import CoreData


class Plan: NSManagedObject {

    /// 总时长
    var total: Double = 0
    /// 单日时长
    var day: Double   = 0
    
    /// 明细分组
    var groups: [[Log]] = []
    
    
    
    func updateDay(date: NSDate) {
        // 时长数据
        let days = Clock.dayRange(date.timeIntervalSince1970)
        
        day = 0
        total = 0
        
        // 分组数据
        var group = [Log]()
        
        // 整理
        logs?.enumerateObjectsUsingBlock({ [weak self] (data, index, pointer) in
            if let log = data as? Log {
                /// 时长统计
                if log.start >= days.start && log.end <= days.end {
                    //print(self?.day)
                    self?.day += log.duration
                }
                self?.total += log.duration
                
                group.append(log)
            }
        })
        
        // 分组
        groups = []
        guard group.count > 0 else { return }
        group.sortInPlace({ $0.start > $1.start })
        var range = Clock.dayRange(group[0].start)
        groups.append([])
        for g in group {
            if g.start >= range.start && g.end <= range.end {
                groups[groups.count-1].append(g)
            } else {
                range = Clock.dayRange(g.start)
                groups.append([g])
            }
        }
    }

}
