//
//  AnimationEngine.swift
//  AwesomeViews
//
//  Created by 黄穆斌 on 16/6/15.
//  Copyright © 2016年 MuBinHuang. All rights reserved.
//

import UIKit

// MARK: - Interface
extension AnimationEngine {
    
    // MARK: Run
    class func Run(duration: NSTimeInterval, timeType: AnimationEngine.TimeType, update: ((schedule: Double) -> Bool)?, completed: (() -> Bool)?) -> Bool {
        let engine = AnimationEngine()
        engine.initValues(duration, function: AnimationEngine.TimeFunction(timeType))
        engine.update    = update
        engine.completed = completed
        return engine.start()
    }
}

// MARK: - Animation Engine
final class AnimationEngine: NSObject {
    
    // MARK: Init
    
    private override init() {
        super.init()
        print("\(self) is init.")
    }
    
    deinit {
        print("\(self) is deinit.")
    }
    
    // MARK: Property
    
    /// RunLoop 每秒在主线程中调用 loop 60 次
    private var displayLink: CADisplayLink?
    
    /// 开始时间
    private var startTime     : NSTimeInterval = 0
    /// 结束时间
    private var endTime       : NSTimeInterval = 0
    /// 持续时间
    private var durationTime  : NSTimeInterval = 0
    
    /// 更新调用的 Block，返回 false 则结束循环。
    private var update: ((schedule: Double) -> Bool)?
    
    /// 动画完成时调用的 Block，返回 false 则重新进行循环。
    private var completed: (() -> Bool)?
    
    /// 动画进度数组
    private var values = [Double]()
    
    // MARK: Mothed
    
    /**
     初始化更新值
     - parameter duration: 持续时间
     - parameter function: 时间函数
     */
    private func initValues(duration: NSTimeInterval, function: (NSTimeInterval) -> NSTimeInterval) {
        durationTime = duration
        let times = Int(duration * 60)
        values = Array(count: times + 1, repeatedValue: 0)
        for i in 0 ..< times {
            values[i] = function(Double(i) / Double(times))
        }
        values[times] = 1
    }
    
    // MARK: Engine
    
    /// 启动引擎。检查持续时间，更新开始结束时间。检查数据值是否正确。
    private func start() -> Bool {
        // 时间
        guard durationTime > 0 else { return false }
        startTime       = CACurrentMediaTime()
        endTime         = startTime + durationTime
        
        // 数据值
        guard values.count == Int(durationTime * 60) + 1 else { return false }
        
        // 开始循环
        if displayLink == nil {
            displayLink = CADisplayLink(target: self, selector: #selector(loop))
            displayLink?.addToRunLoop(NSRunLoop.mainRunLoop(), forMode: NSRunLoopCommonModes)
        }
        return true
    }
    
    /// 引擎运转
    @objc private func loop() {
        // 获取当前时间
        let currentTime = CACurrentMediaTime()
        
        // 运行结束
        if currentTime >= endTime {
            update?(schedule: 1)
            stop()
            return
        }
        
        // 调用更新
        if update?(schedule: values[Int((currentTime - startTime) * 60)]) != true {
            stop()
        }
    }
    
    /// 关闭引擎。
    private func stop() {
        if completed?() == false {
            start()
        } else {
            displayLink?.removeFromRunLoop(NSRunLoop.mainRunLoop(), forMode: NSRunLoopCommonModes)
            displayLink = nil
        }
    }

}

// MARK: - Time Function
extension AnimationEngine {
    
    // MARK: Type
    /**
     - Liner
     - Spring(Double, Double)
        - 计算弹簧效果值的函数，根据：y = 1-e^{-5x} * cos(30x)
        - $0 damping : 默认 5, 范围 0 ... 10~， 数值越大则后期弹性效果越不明显。
        - $1 velocity: 默认 30，范围 0 ... 60~，数值越大波动次数越多
     - returns: 接收单个参数的 spring 函数
     */
    enum TimeType {
        case Liner
        case Spring(Double, Double)
    }
    
    class func TimeFunction(type: TimeType) -> (NSTimeInterval) -> (NSTimeInterval) {
        switch type {
        case .Liner:
            return { return $0 }
        case .Spring(let damping, let velocity):
            return { return 1 - pow(M_E, -damping * $0) * cos(velocity * $0) }
        }
    }
    
}
