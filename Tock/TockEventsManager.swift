//
//  TockEventsManager.swift
//  Tock
//
//  Created by Kevin Turner on 6/15/16.
//  Copyright © 2016 Kevin Turner. All rights reserved.
//

import EventKit

protocol TockEventsFetcherDelegate {
    func remindersFetched(_ reminders: [EKReminder])
}

class TockEventsManager: NSObject
{
    
    var delegate: TockEventsMangerDelegate?
    var requestDelegate : TockEventsFetcherDelegate?
     let eventStore = EKEventStore()
    let today = Date()
    let tomorrow : Date
    
    
    override init() {
       tomorrow = today.addingTimeInterval(60*60*24)
        super.init()
    }
    
    func requestCalendarAccess(){
        
       
        print("requesting cal access: \(eventStore)")
         //let status = EKEventStore.authorizationStatusFor(.event)
         let status = EKEventStore.authorizationStatus(for: .event)
        print(status == .notDetermined)
        eventStore.requestAccess(to: .event, completion: {(status, error) in
           self.delegate?.calendarAccess(status)
        })
    }
    
    
    func requestReminderAccess(){
        let status = EKEventStore.authorizationStatus(for: .reminder)
        if status == .notDetermined {
            eventStore.requestAccess(to: .reminder, completion: {(status, error) in
                self.delegate?.reminderAccess(status)
            })
        }
    }
    
    func getCalendars() -> [String]
    {
        var identifiers = [String]()
        let calendars = eventStore.calendars(for: .event)
        for calendar in calendars {
            identifiers.append(calendar.calendarIdentifier)
        }
        
        return identifiers
    }
    
    
    
    func getEventsForToday() -> [EKEvent]{

        //let predicate = eventStore.predicateForEvents(withStart: today, end: tomorrow, calendars: nil)
        let predicate = eventStore.predicateForEvents(withStart: today, end: tomorrow, calendars: nil)
        var todaysEvents = eventStore.events(matching: predicate)
        
        if !allDayEventsIncluded() {
            var index = 0
            for event in todaysEvents {
                
                if event.isAllDay {
                    todaysEvents.remove(at: index)
                } else {
                    index += 1
                }
                
                         }
        }

        
        return todaysEvents
    }
    
    func getRemindersForToday()  {
        let userDef = UserDefaults.standard
        
        let includesCompleted = userDef.bool(forKey: incompRemindKey)
        var predicate : NSPredicate
        if includesCompleted {
           predicate = eventStore.predicateForReminders(in: nil)
        } else {
            predicate = eventStore.predicateForIncompleteReminders(withDueDateStarting: nil, ending: nil, calendars: nil)
        }
        eventStore.fetchReminders(matching: predicate, completion: {(reminders) in
            if reminders != nil {
                self.requestDelegate?.remindersFetched(reminders!)
            } else {
               self.requestDelegate?.remindersFetched([])
            }
        })
    }
    
    
    func allDayEventsIncluded() -> Bool
    {
        let ud = UserDefaults.standard
        return ud.bool(forKey: isOnKey)
    }
    
    func getEventsOnCalendars(with identifiers: [String]) -> [EKEvent]
    {
        var calendars = [EKCalendar]()
        for id in identifiers {
            calendars.append(eventStore.calendar(withIdentifier: id)!)
        }
        
        let predicate = eventStore.predicateForEvents(withStart: today, end: tomorrow, calendars: calendars)
        return eventStore.events(matching: predicate)
    }
   
}
