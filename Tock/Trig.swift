//
//  Trig.swift
//  Tock
//
//  Created by Kevin Turner on 5/22/16.
//  Copyright © 2016 Kevin Turner. All rights reserved.
//

import Foundation
import CoreGraphics

open class Trig: NSObject
{
    open static func findRadius(_ x: Double, y: Double) -> Double
    {
        if(cos(findAngle(x, y: y)) != 0){
            return x/cos(findAngle(x, y: y))
        }
        
        return -1
    }
    
    
    open static func findAngle(_ x: Double, y: Double) -> Double
    {
        return atan2(y, x)
    }
    
    open static func findPoint(forAngle angle: Double, radius: Double) -> CGPoint
    {
        let y = -CGFloat(sin(angle)*radius)
        let x = CGFloat(cos(angle)*radius)
        
        
        return CGPoint(x: x, y: y)
    }
}
