//
//  GlobalData.swift
//  TimeLog
//
//  Created by 黄穆斌 on 16/7/2.
//  Copyright © 2016年 Myron. All rights reserved.
//

import UIKit
import CoreData

final class AppData {
    
    // MARK: - 单例
    static let shared = AppData()
    private init() { }
    class func deploy() {
        //AppData.shared.testPlansOrder()
    }
    
    // MARK: - CoreData
    
    // MARK: Save
    
    /// 保存数据
    class func saveData() {
        CoreData.save()
    }
    /// 保存顺序
    class func saveOrder() {
        NSUserDefaults.standardUserDefaults().setObject(AppData.shared.plansOrder, forKey: "PlansOrder")
    }
    /// 读取顺序
    class func readOrder() {
        AppData.shared.plansOrder = (NSUserDefaults.standardUserDefaults().objectForKey("PlansOrder") as? [Double]) ?? []
    }
    
    // MARK: Order
    
    /// 计划顺序
    private var plansOrder = [Double]()
    func testPlansOrder() {
        print("====================")
        for plan in plansOrder {
            print(plan)
        }
        print("====================")
    }
    
    // MARK: Add
    /// 添加计划
    class func addPlan(id: Double?) -> Plans {
        let plan = CoreData.insert("Plans") as! Plans
        plan.id = id ?? Double(Int(NSDate().timeIntervalSince1970))
        plan.idle = false
        
        AppData.shared.plansOrder.append(plan.id)
        AppData.saveOrder()
        return plan
    }
    
    /// 添加明细
    class func addLog(plan: Plans) -> Logs {
        let log = CoreData.insert("Logs") as! Logs
        log.plan = plan
        plan.logs?.addObject(log)
        return log
    }
    
    /// 明细记录分裂
    class func splitLog(log: Logs) {
        let dayS = Int(log.start + 28800) / 86400
        let dayE = Int(log.end + 28800) / 86400
        
        if dayE == dayS {
            saveData()
        } else {
            var ranges = [(s: Double, e: Double)]()
            for i in 0 ..< dayE - dayS {
                ranges.append((Double(dayS + i * 86400), Double(dayS + i * 86400 + 86400)))
            }
            
            for range in ranges {
                let new = addLog(log.plan!)
                new.plan = log.plan
                new.note = log.note
                new.start = range.s
                new.end = range.e
                new.duration = range.e - range.s
                saveData()
            }
            
            delete(log)
            saveData()
        }
    }
    
    // MARK: Find
    /// 获取计划列表
    class func find() -> [Plans] {
        if let objects = CoreData.find("Plans", predicate: "id != 0", sorts: [], type: .ManagedObjectResultType, limit: 0, offset: 0) as? [Plans] {
            var plans = [Plans]()
            for order in AppData.shared.plansOrder {
                let index = objects.indexOf({ $0.id == order })!
                plans.append(objects[index])
            }
            return plans
        } else {
            return []
        }
    }
    
    // MARK: 删除
    /// 删除计划
    class func delete(data: NSManagedObject) {
        if let plan = data as? Plans {
            let index = AppData.shared.plansOrder.indexOf(plan.id)!
            AppData.shared.plansOrder.removeAtIndex(index)
        }
        CoreData.delete(data)
    }
    
    // MARK: 移动
    /// 改变计划顺序
    class func move(index: Int, toIndex: Int) {
        (AppData.shared.plansOrder[toIndex], AppData.shared.plansOrder[index]) = (AppData.shared.plansOrder[index], AppData.shared.plansOrder[toIndex])
    }
}
