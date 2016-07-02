//
//  Plans+CoreDataProperties.swift
//  TimeLog
//
//  Created by 黄穆斌 on 16/7/2.
//  Copyright © 2016年 Myron. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Plans {

    @NSManaged var id: Double
    @NSManaged var name: String?
    @NSManaged var note: String?
    @NSManaged var idle: Bool
    @NSManaged var days: Double
    @NSManaged var time: Double
    @NSManaged var json: NSData?
    @NSManaged var logs: NSMutableOrderedSet?

}
