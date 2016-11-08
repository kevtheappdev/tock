//
//  CalendarTockWakeUp.swift
//  Tock
//
//  Created by Kevin Turner on 6/16/16.
//  Copyright © 2016 Kevin Turner. All rights reserved.
//

import Foundation
import EventKit


class CalendarTockWakeUp: TockWakeUp
{
    let teManager = TockEventsManager()
    var events: [EKEvent]!
    
    init(){
        super.init(name: "Calendar")
    }
    
    override func fetchData() {
         events = teManager.getEventsForToday()
         print("All fetched events \(events)")
    }
    
    
    override func stringsToVerbalize() -> [String] {
        var strings = Array<String>()
        
        //strings.append("You have \(self.events.count) events today,")
        for event in events {
            strings.append(event.title)
        }
        
        return strings
    }
}
