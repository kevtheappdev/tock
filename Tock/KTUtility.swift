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
        
        var currentComponents = (calendar as NSCalendar).components([.minute, .hour, .month, .day, .year], from: date)
        
        var hours = currentComponents.hour
        var minutes = currentComponents.minute
         print("The month is \(currentComponents.month!)")
        
        if minutes == 0 {
            minutes = 55
            hours = hours! - 1
        } else {
            minutes = minutes! - 5
        }
        
        currentComponents.hour = hours
        currentComponents.minute = minutes
        
        
        let fetchDate = calendar.date(from: currentComponents)!
        print(fetchDate)
        
        return fetchDate
    }
    
    
    static func setDate(_ hours: Int, minutes: Int)
    {
        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        
        var components = DateComponents()
        
        
        let currentDate = Date()
        
        let currentComponents = (calendar as NSCalendar?)?.components([.month, .day, .year, .hour, .minute], from: currentDate)
        

        var currentDay = currentComponents!.day
        let currentMonth = currentComponents!.month
        let currentYear = currentComponents!.year
        

        
        components.hour = hours
        components.minute = minutes
        components.day = currentDay
        components.month = currentMonth
        components.year = currentYear
        
        
        
        
        let date = calendar.date(from: components)!
        print("date that was saved : \(date) at hour \(hours) and minutes \(minutes)")
        
        let formatter = DateFormatter()
        formatter.dateStyle =  .full
        let timeString = formatter.string(from: date)
        
        print("timeString is \(timeString)")
        
        let defaults = UserDefaults.standard
        defaults.set(date, forKey: wakeUpTimeKey)

        
    }
    
    
    static func getDate() -> Date {
        let defaults = UserDefaults.standard
       var date =  defaults.object(forKey: wakeUpTimeKey) as! Date
        
        
        var components = DateComponents()
        
        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        
        
        let currentDate = Date()

        let currentComponents = (calendar as NSCalendar?)?.components([.month, .day, .year, .hour, .minute], from: currentDate)
        let wakeComponents = (calendar as NSCalendar?)?.components([.hour, .day, .minute], from: date)
        
        let hours = wakeComponents!.hour
        let minutes = wakeComponents!.minute
        
        let currentHour = currentComponents!.hour
        let currentMinute = currentComponents!.minute
        var currentDay = currentComponents!.day
        let currentMonth = currentComponents!.month
        let currentYear = currentComponents!.year
        
        print("currentHour \(currentHour!) and currentMintue \(currentMinute!)")
        print("hour \(hours) and minute is \(minutes)")
        
        if currentHour! > hours! {
            currentDay = currentDay! + 1
            print("added \(currentHour)")
        } else if currentHour! == hours! && currentMinute! > minutes! {
            currentDay = currentDay! + 1
        }
        
        components.hour = hours
        components.minute = minutes
        components.month = currentMonth
        components.year = currentYear
        components.day = currentDay
        
        date = calendar.date(from: components)!

        return date
    }
    
    
    
    static func setDefaultWakeups(){
        //let userDefaults = UserDefaults.standard()
        
        
    }
}
