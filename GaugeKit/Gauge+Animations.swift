//
//  Gauge+Animations.swift
//  GaugeKit
//
//  Created by David Pelletier on 16-03-30.
//  Copyright © 2016 Petr Korolev. All rights reserved.
//

import UIKit

extension GaugeView {

    public func animateValue(_ duration: TimeInterval, newValue: CGFloat, completion: @escaping (Bool) -> Void) -> Void {
        animationTimer.invalidate()
        
        let refreshRate: TimeInterval = 0.1
        let speed = CGFloat(refreshRate) * ((newValue - value) / CGFloat(duration))

        animationTimer = .scheduledTimer(
            timeInterval: refreshRate,
            target: self,
            selector: #selector(updateProgress(_:)),
            userInfo: [newValue, speed],
            repeats: true
        )
        
        animationTimer.fire()
        
        animationCompletion = completion
    }
    
    @objc func updateProgress(_ timer: Timer) -> Void {
        let userInfo = timer.userInfo as! [CGFloat]
        guard let newValue = userInfo.first else {
            print("GAUGE-KIT: Error, new value not defined...")
            return
        }
        
        guard let speed = userInfo.last else {
            print("GAUGE-KIT: Error, rate speed could not be defined...")
            return
        }
        
        value += speed

        if speed < 0 {
            if value <= newValue {
                value = newValue
                timer.invalidate()
                animationCompletion?(true)
            }
            
            if value <= 0 {
                value = 0
                timer.invalidate()
                animationCompletion?(true)
            }
        }
        
        if speed >= 0 {
            if value >= newValue {
                value = newValue
                timer.invalidate()
                animationCompletion?(true)
            }
            
            if value >= maxValue {
                value = maxValue
                timer.invalidate()
                animationCompletion?(true)
            }
        }
    }
}
