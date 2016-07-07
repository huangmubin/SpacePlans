//
//  Plans.swift
//  TimeLog
//
//  Created by 黄穆斌 on 16/7/2.
//  Copyright © 2016年 Myron. All rights reserved.
//

import Foundation
import CoreData


class Plans: NSManagedObject {

    func duration() -> Double {
        var time = 0.0
        if let logs = logs {
            logs.forEach {
                if let log = $0 as? Logs {
                    time += log.duration
                }
            }
        }
        return time
    }
    
    func day(date: NSDate) -> Double {
        var time = 0.0
        if let logs = logs {
            let range = ClockTools.dayRange(date)
            let start = range.start.timeIntervalSince1970
            let end   = range.end.timeIntervalSince1970
            logs.forEach {
                if let log = $0 as? Logs {
                    if log.start >= start && log.start < end {
                        time += log.duration
                    }
                }
            }
        }
        return time
    }
}
