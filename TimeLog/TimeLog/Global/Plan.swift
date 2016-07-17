//
//  Plan.swift
//  TimeLog
//
//  Created by 黄穆斌 on 16/7/11.
//  Copyright © 2016年 Myron. All rights reserved.
//

import Foundation
import CoreData

enum UpdateType {
    case Total
    case Duration
    case TotalAndDuration
    case Groups(Double, Double)
    case GroupsAndTotal(Double, Double)
}

enum GroupType {
    case Day
}

func InRange<T: Comparable>(i: T, s: T, e: T) -> Bool {
    return i >= s && i < e
}

class Plan: NSManagedObject {

    /// 总时长
    var total: Double = 0
    /// 持续时间
    var duration: Double = 0
    /// Log
    var logs: [Log] = []
    /// 明细分组
    var groups: [[Log]] = []
    
    // MARK: Methods
    
    func deploy() {
        logs.removeAll(keepCapacity: true)
        detail?.enumerateObjectsUsingBlock({ [weak self] (data, index, pointer) in
            if let log = data as? Log {
                self?.logs.append(log)
            }
        })
        logs.sortInPlace({ $0.start < $1.start })
    }
    
    func update(type: UpdateType) {
        switch type {
        case .Total:
            logs.forEach {
                self.total += $0.duration
            }
        case .Duration:
            logs.forEach {
                if InRange($0.duration, s: Range.start, e: Range.end) {
                    self.duration += $0.duration
                }
            }
        case .TotalAndDuration:
            logs.forEach {
                self.total += $0.duration
                if InRange($0.duration, s: Range.start, e: Range.end) {
                    self.duration += $0.duration
                }
            }
        case .Groups(let start, let end):
            logs.forEach {
                if InRange($0.duration, s: start, e: end) {
                    self.duration += $0.duration
                }
            }
        case .GroupsAndTotal(let start, let end):
            logs.forEach {
                self.total += $0.duration
                if InRange($0.duration, s: start, e: end) {
                    self.duration += $0.duration
                }
            }
        }
    }

    func deployGroup(type: GroupType) {
        guard logs.count > 0 else { return }
        groups.removeAll(keepCapacity: true)
        groups.append([])
        switch type {
        case .Day:
            var range = Clock.dayRange(logs[0].start)
            for log in logs {
                if InRange(log.start, s: range.start, e: range.end) {
                    groups[groups.count-1].append(log)
                } else {
                    range = Clock.dayRange(log.start)
                    groups.append([log])
                }
            }
        }
    }
}
