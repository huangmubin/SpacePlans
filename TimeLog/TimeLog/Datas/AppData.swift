//
//  GlobalData.swift
//  TimeLog
//
//  Created by 黄穆斌 on 16/7/2.
//  Copyright © 2016年 Myron. All rights reserved.
//

import UIKit

final class AppData {
    
    // MARK: - 单例
    static let shared = AppData()
    private init() { }
    class func deploy() {
        AppData.shared.testPlansOrder()
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
    
    private func addOrder(plan: Double) {
        plansOrder.append(plan)
    }
    
    // MARK: Add
    /// 添加计划
    class func addPlan(id: Double?) -> Plans {
        let plan = CoreData.insert("Plans") as! Plans
        plan.id = id ?? Double(Int(NSDate().timeIntervalSince1970))
        plan.idle = false
        
        AppData.shared.addOrder(plan.id)
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
    
    // MARK: Find
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
}
