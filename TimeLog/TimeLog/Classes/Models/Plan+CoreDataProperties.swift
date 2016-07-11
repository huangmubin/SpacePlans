//
//  Plan+CoreDataProperties.swift
//  TimeLog
//
//  Created by 黄穆斌 on 16/7/11.
//  Copyright © 2016年 Myron. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Plan {

    @NSManaged var days: Double
    @NSManaged var id: Double
    @NSManaged var idle: Bool
    @NSManaged var json: NSData?
    @NSManaged var name: String?
    @NSManaged var note: String?
    @NSManaged var time: Double
    @NSManaged var logs: NSMutableOrderedSet?

}
