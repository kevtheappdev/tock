//
//  RemindersTockWakeUp.swift
//  Tock
//
//  Created by Kevin Turner on 12/13/16.
//  Copyright © 2016 Kevin Turner. All rights reserved.
//

import UIKit
import EventKit

class RemindersTockWakeUp: TockWakeUp, TockEventsFetcherDelegate {
    let teManager = TockEventsManager()
    var reminders : [EKReminder]!
    
    init(){
        super.init(name: "Reminders")
    }
    
    override func fetchData() {
        teManager.requestDelegate = self
        teManager.getRemindersForToday()
    }
    
    func remindersFetched(_ reminders: [EKReminder]) {
        self.fetchSuccess = true
        self.reminders = reminders
    }
    
    override func stringsToVerbalize() -> [String] {
        var strings = Array<String>()
        print("reminders \(reminders)")
        for reminder in reminders {
            strings.append(reminder.title)
        }
        
        if strings.count == 0 {
            strings.append("You have no reminders")
        }
        
        return strings
    }
}
