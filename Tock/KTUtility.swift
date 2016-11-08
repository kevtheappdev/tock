//
//  KTUtility.swift
//  Tock
//
//  Created by Kevin Turner on 5/28/16.
//  Copyright © 2016 Kevin Turner. All rights reserved.
//

import Foundation
import UIKit



class KTUtility: NSObject
{
    
    static func onboardComplete() -> Bool
    {
        let defaults = UserDefaults.standard
        let onboarded = defaults.object( forKey: onboardedKey) as? Bool
        if onboarded == nil {
            print("was false")
            return false
        }
        return onboarded!
    }
    
    static func makeFetchDate(_ date: Date) -> Date {
        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        
        var currentComponents = (calendar as NSCalendar).components([.minute, .hour], from: date)
        
        var hours = currentComponents.hour
        var minutes = currentComponents.minute
        
        if minutes == 0 {
            minutes = 55
            hours = hours! - 1
        } else {
            minutes = minutes! - 5
        }
        
        currentComponents.hour = hours
        currentComponents.minute = minutes
        
        let fetchDate = calendar.date(from: currentComponents)!
        
        
        return fetchDate
    }
    
    
    static func setDate(_ hours: Int, minutes: Int)
    {
        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        
        var components = DateComponents()
        
        
        let currentDate = Date()
        
        let currentComponents = (calendar as NSCalendar?)?.components([.month, .day, .year, .hour, .minute], from: currentDate)
        
        let currentHour = currentComponents!.hour
        let currentMinute = currentComponents!.minute
        var currentDay = currentComponents!.day
        let currentMonth = currentComponents!.month
        let currentYear = currentComponents!.year
        
        
        if currentHour! > hours && currentMinute! > minutes {
            currentDay = currentDay! + 1
            print("added \(currentHour)")
        }
        
        
        components.hour = hours
        components.minute = minutes
        components.day = currentDay
        components.month = currentMonth
        components.year = currentYear
        
        
        let date = calendar.date(from: components)!
        
        let formatter = DateFormatter()
        formatter.dateStyle =  .long
        let timeString = formatter.string(from: date)
        
        print(timeString)
        
        let defaults = UserDefaults.standard
        defaults.set(date, forKey: wakeUpTimeKey)

        
    }
    
    
    
    static func setDefaultWakeups(){
        //let userDefaults = UserDefaults.standard()
        
        
    }
}
