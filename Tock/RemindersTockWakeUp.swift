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
    var reminderCount = 1
    
    init(){
        super.init(name: "Reminders")
    }
    
    override func fetchData() {
        teManager.requestDelegate = self
        teManager.getRemindersForToday()
    }
    
    func remindersFetched(_ reminders: [EKReminder]) {
        self.fetchSuccess = reminders.count > 0
        self.reminders = reminders
        reminderCount = reminders.count > 1 ? reminders.count : 1
        self.failedString = "No Reminders"
        self.delegate?.finishedDataFetch()
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
