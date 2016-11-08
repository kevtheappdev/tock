//
//  TockEventsManager.swift
//  Tock
//
//  Created by Kevin Turner on 6/15/16.
//  Copyright © 2016 Kevin Turner. All rights reserved.
//

import EventKit

class TockEventsManager: NSObject
{
    
    var delegate: TockEventsMangerDelegate?
     let eventStore = EKEventStore()
    
    func requestCalendarAccess(){
        
       
        print("requesting cal access: \(eventStore)")
         //let status = EKEventStore.authorizationStatusFor(.event)
         let status = EKEventStore.authorizationStatus(for: .event)
        print(status == .notDetermined)
        eventStore.requestAccess(to: .event, completion: {(status, error) in
           self.delegate?.calendarAccess(status)
        })
    }
    
    
    func getEventsForToday() -> [EKEvent]{
        let today = Date()
        let tomorrow = today.addingTimeInterval(60*60*24)
        //let predicate = eventStore.predicateForEvents(withStart: today, end: tomorrow, calendars: nil)
        let predicate = eventStore.predicateForEvents(withStart: today, end: tomorrow, calendars: nil)
        let todaysEvents = eventStore.events(matching: predicate)
        return todaysEvents
    }
   
}
