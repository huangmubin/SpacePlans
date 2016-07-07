//
//  InitDatas.swift
//  TimeLog
//
//  Created by 黄穆斌 on 16/7/2.
//  Copyright © 2016年 Myron. All rights reserved.
//

import UIKit

class InitDatas {

    struct Plan {
        var id: Double
        var name: String?
        var note: String?
        var idle: Bool
        var days: Double
        var time: Double
        var logs: [Log]
    }
    
    struct Log {
         var note: String?
         var start: Double
         var end: Double
    }
    
    class func deployApp() {
        NSUserDefaults.standardUserDefaults().registerDefaults(["deployApp": true])
        guard NSUserDefaults.standardUserDefaults().boolForKey("deployApp") else {
            return
        }
        NSUserDefaults.standardUserDefaults().setBool(false, forKey: "deployApp")
        
        let deploy = [
            Plan(id: 1467444553.0,
                name: "英语阅读训练",
                note: "我要让我的视野扩展半个世界。",
                idle: false,
                days: 10.0,
                time: 3600.0,
                logs: [
                    Log(note: "翻译 iOS Human Interface Guidelines", start: 1467334800, end: 1467338400),
                    Log(note: "翻译 The Swift Programming Language", start: 1467421200, end: 1467424800),
                    Log(note: "翻译 Core Animation Programming Guide", start: 1467507600, end: 1467511200),
                    Log(note: "翻译 Core Data Programming Guide", start: 1467594000, end: 1467597600)
                ]),
            Plan(id: 1467444554.0,
                name: "Swift 学习",
                note: "编程改变世界，学习改变人生。",
                idle: false,
                days: 10.0,
                time: 3600.0,
                logs: [
                    Log(note: "学习 Class 跟 Struct", start: 1467338400, end: 1467345600),
                    Log(note: "学习 if Switch", start: 1467424800, end: 1467432000),
                    Log(note: "学习 Extension", start: 1467511200, end: 1467518400),
                    Log(note: "学习 Protocol", start: 1467597600, end: 1467604800)
                ]),
            Plan(id: 1467444555.0,
                name: "健身",
                note: "请给我六块腹肌还有人鱼线。",
                idle: false,
                days: 10.0,
                time: 1800.0,
                logs: [
                    Log(note: "训练", start: 1467356400, end: 1467358200),
                    Log(note: "训练", start: 1467442800, end: 1467444600),
                    Log(note: "训练", start: 1467529200, end: 1467531000),
                    Log(note: "训练", start: 1467615600, end: 1467617400)
                ]),
            Plan(id: 1467444556.0,
                name: "旅游",
                note: "走遍大江南北",
                idle: true,
                days: 10.0,
                time: 3600.0,
                logs: [
                ]),
            Plan(id: 1467444557.0,
                name: "跑步",
                note: "耐力！！！",
                idle: true,
                days: 10.0,
                time: 3600.0,
                logs: [
                ])
        ]
        
        for data in deploy {
            let plan = AppData.addPlan(data.id)
            plan.name = data.name
            plan.note = data.note
            plan.idle = data.idle
            plan.days = data.days
            plan.time = data.time
            if plan.idle {
                AppData.shared.idlePlan(plan.id)
            }
            AppData.saveData()
            for log in data.logs {
                let detail = AppData.addLog(plan)
                detail.note = log.note
                detail.start = log.start
                detail.end = log.end
                detail.duration = log.end - log.start
                AppData.saveData()
            }
        }
        
        AppData.saveOrder()
    }
    
}
