//
//  TockWakeUp.swift
//  Tock
//
//  Created by Kevin Turner on 6/15/16.
//  Copyright © 2016 Kevin Turner. All rights reserved.
//

import Foundation


protocol TockWakeUpDelegate {
    func finishedDataFetch()
}

open class TockWakeUp: NSObject
{
    
    fileprivate var name: String!
    var delegate: TockWakeUpDelegate?
    
    
    open var alarmName: String {
        get {return name}
        set {name = newValue}
    }

    public init(name: String){
        self.name = name
        super.init()
     
    }
    
    
    open func fetchData(){
        print("fetch data to wake your ass up")
    }
    
    open func stringsToVerbalize() -> [String]{
        return ["Welcome to Tock!"]
    }
    
    
}
