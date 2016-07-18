//
//  AppData.swift
//  TimeLog
//
//  Created by 黄穆斌 on 16/7/11.
//  Copyright © 2016年 Myron. All rights reserved.
//

import UIKit
import CoreData

// MARK: Global Data
struct DataIndex {
    /// true is Plan, false is Log
    var type: Bool = true
    /// is Idles or Plans
    var idle: Bool = false
    /// Plan[index]
    var index: Int?
    /// Plan[index].logs[detail]
    var deital: Int?
    
    func takePlan() -> Plan? {
        if index == nil {
            return nil
        } else {
            return idle ? Idles[index!] : Plans[index!]
        }
    }
    
    func takeIdle() -> Log? {
        if index == nil || deital == nil {
            return nil
        } else {
            return idle ? Idles[index!].logs[deital!] : Plans[index!].logs[deital!]
        }
    }
}

/// 正常计划列表
var Plans: [Plan] = [Plan]()
/// 闲置计划列表
var Idles: [Plan] = [Plan]()
/// 区间范围
var Range: (start: Double, end: Double) = (0,0)

class AppData {
    
    // MARK: - Values
    
    // MARK: Single
    
    static let shared: AppData = AppData()
    private init() {}
    
    // MARK: Range
    
    //var range: (start: Double, end: Double) = (0,0)
    
    // MARK: Data
    
    //var plans: [Plan] = [Plan]()
    //var idles: [Plan] = [Plan]()
    var order: (plan: [Double], idle: [Double]) = ([],[])
    //var planListChoicePlan: Plan?
    
    // MARK: - Methods
    
    /// 初始化配置
    class func deploy() {
        
        // 顺序
        AppData.shared.order.plan = (NSUserDefaults.standardUserDefaults().objectForKey("OrderPlan") as? [Double]) ?? []
        AppData.shared.order.idle = (NSUserDefaults.standardUserDefaults().objectForKey("OrderIdle") as? [Double]) ?? []
        
        // 初始化数据
        let datas = (CoreData.find("Plan", predicate: "id != 0", sorts: [], type: .ManagedObjectResultType, limit: 0, offset: 0) as? [Plan]) ?? [Plan]()
        
        for id in AppData.shared.order.plan {
            let index = datas.indexOf({ $0.id == id })!
            // AppData.shared.plans.append(datas[index])
            Plans.append(datas[index])
        }
        for id in AppData.shared.order.idle {
            let index = datas.indexOf({ $0.id == id })!
            // AppData.shared.idles.append(datas[index])
            Idles.append(datas[index])
        }
        
        //print("\(self) - \(#function): Order = \(AppData.shared.order)")
    }
    
    // MARK: Data
    
    /// 移除计划
    class func removePlan(idle: Bool, index: Int) {
        if idle {
            // let data = AppData.shared.idles.removeAtIndex(index)
            let data = Idles.removeAtIndex(index)
            delete(data)
            
            AppData.shared.order.idle.removeAtIndex(index)
        } else {
            //let data = AppData.shared.plans.removeAtIndex(index)
            let data = Plans.removeAtIndex(index)
            delete(data)
            
            AppData.shared.order.plan.removeAtIndex(index)
        }
        AppData.save()
        AppData.saveOrder()
        Notify.post(NotifyType.Reload)
    }
    
    /// 保存计划
//    class func save(reload: Bool, info: AnyObject?) {
//        CoreData.save()
//        if let info = info {
//            Notify.post(reload ? NotifyType.Reload : NotifyType.Update, info: info)
//        } else {
//            Notify.post(reload ? NotifyType.Reload : NotifyType.Update)
//        }
//    }
    
    /// 明细分割并保存
    class func logSplit(log: Log) {
        var day   = Clock.dayRange(NSDate(timeIntervalSince1970: log.start)).end.timeIntervalSince1970
        var start = log.start
        let end   = log.end
        var data  = log
        //print("\(self) - \(#function): plan.id = \(log.plan!.id); start = \(start); end = \(end); day = \(day); data = \(data);")
        while start < end {
            if end < day {
                start = end
                data.end = end
                data.duration = data.end - data.start
                save()
            } else {
                data.end = day
                data.duration = data.end - data.start
                start = day
                day += 86400
                
                guard start < end else { save(); return }
                
                data = AppData.addLog(log.plan!)
                data.note = log.note
                data.json = log.json
                data.start = start
                save()
            }
            //print("\(self) - \(#function): id = \(data.plan!.id); start = \(start); end = \(end); day = \(day); data = \(data);")
        }
    }
    
    // MARK: Order
    
    /// 顺序变更 idle == true
    class func orderChanged(origin: Bool, now: Bool, id: Double) -> Bool {
        switch (origin, now) {
        case (true, false):
            let index = AppData.shared.order.idle.indexOf(id)!
            AppData.shared.order.idle.removeAtIndex(index)
            AppData.shared.order.plan.append(id)
            
            let data = Idles.removeAtIndex(index)
            data.idle = now
            Plans.append(data)
            
        case (false, true):
            let index = AppData.shared.order.plan.indexOf(id)!
            AppData.shared.order.plan.removeAtIndex(index)
            AppData.shared.order.idle.append(id)
            
            let data = Plans.removeAtIndex(index)
            data.idle = now
            Idles.append(data)
        default:
            return false
        }
        AppData.saveOrder()
        return true
    }
    
    // MARK: - Core
    
    // MARK: Database
    
    /// 添加计划
    class func addPlan() -> Plan {
        let plan = CoreData.insert("Plan") as! Plan
        plan.id = Double(Int(NSDate().timeIntervalSince1970))
        // AppData.shared.plans.append(plan)
        Plans.append(plan)
        AppData.shared.order.plan.append(plan.id)
        AppData.saveOrder()
        return plan
    }
    
    /// 添加明细
    class func addLog(plan: Plan) -> Log {
        let log = CoreData.insert("Log") as! Log
        log.plan = plan
        // plan.logs?.addObject(log)
        plan.detail?.addObject(log)
        plan.logs.append(log)
        return log
    }
    
    /// 删除计划
    class func delete(data: NSManagedObject) {
        if let plan = data as? Plan {
            for log in plan.logs {
                CoreData.delete(log)
            }
//            if let logs = plan.logs {
//                for log in logs {
//                    CoreData.delete(log as! Log)
//                }
//            }
            if plan.idle {
                let index = AppData.shared.order.idle.indexOf(plan.id)!
                AppData.shared.order.idle.removeAtIndex(index)
            } else {
                let index = AppData.shared.order.plan.indexOf(plan.id)!
                AppData.shared.order.plan.removeAtIndex(index)
            }
            saveOrder()
        }
        CoreData.delete(data)
    }
    
    class func save() {
        CoreData.save()
    }
    
    // MARK: Order
    
    class func unidlePlan(id: Double) {
        let index = AppData.shared.order.idle.indexOf(id)!
        AppData.shared.order.idle.removeAtIndex(index)
        AppData.shared.order.plan.append(id)
    }
    
    class func idlePlan(id: Double) {
        let index = AppData.shared.order.plan.indexOf(id)!
        AppData.shared.order.plan.removeAtIndex(index)
        AppData.shared.order.idle.append(id)
    }
    
    class func moveOrder(plan: Bool, index: Int, toIndex: Int) {
        if plan {
            let id = AppData.shared.order.plan.removeAtIndex(index)
            AppData.shared.order.plan.insert(id, atIndex: toIndex)
        } else {
            let id = AppData.shared.order.idle.removeAtIndex(index)
            AppData.shared.order.idle.insert(id, atIndex: toIndex)
        }
    }
    
    class func addOrder(plan: Bool, id: Double) {
        if plan {
            AppData.shared.order.plan.append(id)
        } else {
            AppData.shared.order.idle.append(id)
        }
    }
    
    class func saveOrder() {
        print("\(self) - \(#function): Order = \(AppData.shared.order)")
        NSUserDefaults.standardUserDefaults().setObject(AppData.shared.order.plan, forKey: "OrderPlan")
        NSUserDefaults.standardUserDefaults().setObject(AppData.shared.order.idle, forKey: "OrderIdle")
    }
}
