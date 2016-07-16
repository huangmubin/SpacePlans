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
    
    /*
    func updateTotal() {
        total = 0
        logs?.enumerateObjectsUsingBlock({ [weak self] (data, index, pointer) in
            if let log = data as? Log {
                self?.total += log.duration
            }
        })
    }
    */
    
    func updateDay(date: NSDate) {
        let days = Clock.dayRange(date)
        let start = days.start.timeIntervalSince1970
        let end   = days.end.timeIntervalSince1970
        day = 0
        total = 0
        logs?.enumerateObjectsUsingBlock({ [weak self] (data, index, pointer) in
            if let log = data as? Log {
                //print("\n\nstart \(log.start); end \(log.end);\nstart \(start); end \(end);\n\n")
                if log.start >= start && log.end <= end {
                    //print(self?.day)
                    self?.day += log.duration
                }
                self?.total += log.duration
                //print(self?.day)
            }
        })
    }

}
