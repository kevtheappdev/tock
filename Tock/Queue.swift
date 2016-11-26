//
//  Queue.swift
//  Tock
//
//  Created by Kevin Turner on 11/22/16.
//  Copyright © 2016 Kevin Turner. All rights reserved.
//

import UIKit

public class Queue <T> : NSObject {
    private var items : [T] = [T]()
    
    
    public func queue(item: T)
    {
        items.append(item)
    }
    
    public func deQueue() -> T
    {
        return items.remove(at: 0)
    }
    
    public func peek() -> T
    {
        return items[0]
    }
    
    
    public func hasNext() -> Bool
    {
        return items.count > 0
    }
    
    
}
