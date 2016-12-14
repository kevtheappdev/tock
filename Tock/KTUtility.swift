//
//  KTUtility.swift
//  Tock
//
//  Created by Kevin Turner on 5/28/16.
//  Copyright © 2016 Kevin Turner. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications



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
    
    
    static func getCurrentDate() -> String
    {
        let date = Date()
        
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        dateFormatter.timeZone = NSTimeZone.system
        
        
        var dateString = dateFormatter.string(from: date)
        let index = dateString.index(dateString.startIndex, offsetBy: 2)
        let hours = dateString.substring(to: index)
        
    
        
       let minutes = dateString.substring(from: index)
        
        var h = Int(hours)!
        var postFix = " AM"
        if h > 12 {
            h = h - 12
            postFix = " PM"
        }
        
        dateString = "\(h)" + minutes + postFix
        
        return dateString
        
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
    
    
    static func scheduleNotification()
    {
        func createNotification(withTrigger trigger: UNNotificationTrigger){
            let content = UNMutableNotificationContent()
            content.title = "Start Tock Alarm"
            content.body = "Don't forget to leave Tock running before you go to bed to recieve your morning greeting!"
            content.sound = UNNotificationSound.default()
            
            let request = UNNotificationRequest(identifier: "openReminder", content: content, trigger: trigger)
            UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
            
            print("notification created")
        }
        
        

        let typStartTime = averageStartTime() // set the notification to be the average time
        if typStartTime > 0 {
           let date = minutesToDate(minutes: typStartTime)

          print("date hour : \(date.hour) minute: \(date.minute)")
         // print("components hour \(components.hour) minute \(components.minute) day \(components.day) month \(components.month) year \(components.year)")
            let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
            //let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 30, repeats: false)
            createNotification(withTrigger: trigger)
            print("The next trigger date is \(trigger.nextTriggerDate())")
         } else {
            let wakeDate = getDate()
            let wakeMinutes = timeInMinutes(fromDate: wakeDate)
            let eightHours = 8 * 60 // If an avereage doesn't exists yet then set it to 8 hours before the wake up time
          
            let reminderTime = wakeMinutes - eightHours
            let date = minutesToDate(minutes: reminderTime)
            
            
        
        
            let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
            
            createNotification(withTrigger: trigger)
        }
        
        
    }
    
    static func recordStartTime(){
        let currentDate = Date()
        
        let defaults = UserDefaults.standard
        
        let fetchedTimes = defaults.array(forKey: launchTimesKey) as? [Int]
        
        if var times = fetchedTimes {
            if times.count > 5 {
                times.remove(at: 0)
            }
            let minuteTime = timeInMinutes(fromDate: currentDate)
            times.append(minuteTime)
            
            defaults.set(times, forKey: launchTimesKey)
        } else {
            defaults.set([timeInMinutes(fromDate: currentDate)], forKey: launchTimesKey)
        }
        
    }
    
    
    static func timeInMinutes(fromDate date: Date) -> Int {
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = .current
        let dateComp = calendar.dateComponents([.hour, .minute], from: date)
        let hours = dateComp.hour!
        let minutes = dateComp.minute!
        
        return (hours*60) + minutes
    }
    
    static func minutesToDate(minutes: Int) -> DateComponents
    {
        let hours = minutes / 60
        let minutes = minutes % 60
        var calendar = Calendar(identifier: .gregorian)
        calendar.timeZone = TimeZone.current
        var components = DateComponents()
        
        components.hour = hours
        components.minute = minutes
        
        return components
    }
    
    
    //Returns the average time that the user opens the app to start the alarm
    static func averageStartTime() -> Int
    {
        let defaults = UserDefaults.standard
        let fetchedTimes = defaults.array(forKey: launchTimesKey) as? [Int]
        
        var sum = 0
        if let times = fetchedTimes {
            let sortedTimes = times.sorted()
            print("Total sorted tiems is \(sortedTimes)")
            if sortedTimes.count > 2 {
                for x in 1..<(sortedTimes.count-1){
                    sum += sortedTimes[x] // average only the middle, excluding the highest and the lowest
                }
            } else if sortedTimes.count == 1 {
                return sortedTimes[0] // if there is only one return that
            } else if sortedTimes.count == 2{
                return Int((sortedTimes[1] + sortedTimes[0])/2) // if there are only two average the two
            } else {
                return -1
            }
            let average = Double(sum)/Double(times.count-2)
            print("The average is \(Int(round(average)))")
            return Int(round(average))
        } else {
            return -1
        }
        
    }
    
    
    
    static func setDefaultWakeups(){
        //let userDefaults = UserDefaults.standard()
        
        
    }
}
