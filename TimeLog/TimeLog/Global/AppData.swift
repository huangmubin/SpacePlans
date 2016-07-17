//
//  AppData.swift
//  TimeLog
//
//  Created by 黄穆斌 on 16/7/11.
//  Copyright © 2016年 Myron. All rights reserved.
//

import UIKit
import CoreData

class AppData {
    
    // MARK: - Values
    
    // MARK: Single
    
    static let shared: AppData = AppData()
    private init() {}
    
    // MARK: Data
    
    var plans: [Plan] = [Plan]()
    var idles: [Plan] = [Plan]()
    var order: (plan: [Double], idle: [Double]) = ([],[])
    var planListChoicePlan: Plan?
    
    subscript (idle: Bool, index: Int) -> Plan {
        get {
            return idle ? idles[index] : plans[index]
        }
    }
    
    // MARK: - Methods
    
    class func deploy() {
        
        // 顺序
        AppData.shared.order.plan = (NSUserDefaults.standardUserDefaults().objectForKey("OrderPlan") as? [Double]) ?? []
        AppData.shared.order.idle = (NSUserDefaults.standardUserDefaults().objectForKey("OrderIdle") as? [Double]) ?? []
        
        // 初始化数据
        let datas = (CoreData.find("Plan", predicate: "id != 0", sorts: [], type: .ManagedObjectResultType, limit: 0, offset: 0) as? [Plan]) ?? [Plan]()
        let date = NSDate()
        for id in AppData.shared.order.plan {
            let index = datas.indexOf({ $0.id == id })!
            AppData.shared.plans.append(datas[index])
            datas[index].updateDay(date)
        }
        for id in AppData.shared.order.idle {
            let index = datas.indexOf({ $0.id == id })!
            AppData.shared.idles.append(datas[index])
            datas[index].updateDay(date)
        }
        
        //print("\(self) - \(#function): Order = \(AppData.shared.order)")
    }
    
    // MARK: Data
    
    class func removePlan(idle: Bool, index: Int) {
        if idle {
            let data = AppData.shared.idles.removeAtIndex(index)
            delete(data)
            
            AppData.shared.order.idle.removeAtIndex(index)
        } else {
            let data = AppData.shared.plans.removeAtIndex(index)
            delete(data)
            
            AppData.shared.order.plan.removeAtIndex(index)
        }
        AppData.save()
        AppData.saveOrder()
        Notify.post(NotifyType.Reload)
    }
    
    class func save(reload: Bool, info: AnyObject?) {
        CoreData.save()
        if let info = info {
            Notify.post(reload ? NotifyType.Reload : NotifyType.Update, info: info)
        } else {
            Notify.post(reload ? NotifyType.Reload : NotifyType.Update)
        }
    }
    
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
    
    /// idle == true
    class func orderChanged(origin: Bool, now: Bool, id: Double) {
        switch (origin, now) {
        case (true, false):
            let index = AppData.shared.order.idle.indexOf(id)!
            AppData.shared.order.idle.removeAtIndex(index)
            AppData.shared.order.plan.append(id)
            
            let data = AppData.shared.idles.removeAtIndex(index)
            data.idle = now
            AppData.shared.plans.append(data)
        case (false, true):
            let index = AppData.shared.order.plan.indexOf(id)!
            AppData.shared.order.plan.removeAtIndex(index)
            AppData.shared.order.idle.append(id)
            
            let data = AppData.shared.plans.removeAtIndex(index)
            data.idle = now
            AppData.shared.idles.append(data)
        default:
            break
        }
        AppData.saveOrder()
    }
    
    // MARK: - Core
    
    // MARK: Database
    
    class func addPlan() -> Plan {
        let plan = CoreData.insert("Plan") as! Plan
        plan.id = Double(Int(NSDate().timeIntervalSince1970))
        AppData.shared.plans.append(plan)
        AppData.shared.order.plan.append(plan.id)
        AppData.saveOrder()
        return plan
    }
    
    class func addLog(plan: Plan) -> Log {
        let log = CoreData.insert("Log") as! Log
        log.plan = plan
        plan.logs?.addObject(log)
        return log
    }
    
    class func delete(data: NSManagedObject) {
        if let plan = data as? Plan {
            if let logs = plan.logs {
                for log in logs {
                    CoreData.delete(log as! Log)
                }
            }
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
