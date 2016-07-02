//
//  CoreData.swift
//  TimeLog
//
//  Created by 黄穆斌 on 16/7/2.
//  Copyright © 2016年 Myron. All rights reserved.
//

import UIKit
import CoreData

class CoreData {

    static let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
    
    // MARK: - 常用方法 - 保存，删除，插入，查找
    
    /// 保存数据。
    class func save() {
        delegate.saveContext()
    }
    
    /// 删除数据。
    class func delete(data: NSManagedObject) {
        delegate.managedObjectContext.deleteObject(data)
    }
    
    /// 插入新数据
    class func insert(name: String) -> NSManagedObject {
        return NSEntityDescription.insertNewObjectForEntityForName(name, inManagedObjectContext: delegate.managedObjectContext)
    }

    /**
     根据完整的条件进行数据返回。（完整版）
     - parameter name: 数据库名称
     - parameter predicate: 查询条件
     - parameter sorts: 排序条件
     - parameter type: 返回数据的类型 <br/>
     ManagedObjectResultType     : 数据库对象（默认）[NSManagedObject] <br/>
     ManagedObjectIDResultType   : 返回特殊的标记，而不是真实的对象，其实这个有点儿像 hashCode 的意思，类似于数据库的主键。 <br/>
     DictionaryResultType        : 把数据对象字典化 [[String:AnyObject]] <br/>
     CountResultType             : 数据数量 [Int]
     - parameter limit: 限制查询结果数目
     - parameter offset: 忽略查询结果的前几条
     - returns: 数据库对象。 实际上应该都是 NSArray?
     */
    class func find(name: String, predicate: String, sorts: [(String, Bool)], type: NSFetchRequestResultType, limit: Int, offset: Int) -> AnyObject? {
        // Request
        let request = NSFetchRequest(entityName: name)
        
        // Sort
        request.sortDescriptors = sorts.flatMap { return NSSortDescriptor(key: $0.0, ascending: $0.1) }
        
        // Predicate
        request.predicate = NSPredicate(format: predicate)
        
        // ResultType
        /*
         ManagedObjectResultType     : 数据库对象（默认）[NSManagedObject]
         ManagedObjectIDResultType   : 返回特殊的标记，而不是真实的对象，其实这个有点儿像 hashCode 的意思，类似于数据库的主键。
         DictionaryResultType        : 把数据对象字典化 [[String:AnyObject]]
         CountResultType             : 数据数量 [Int]
         */
        request.resultType = type
        
        // Limit
        request.fetchLimit = limit
        request.fetchOffset = offset
        
        return try? delegate.managedObjectContext.executeFetchRequest(request)
    }
}
