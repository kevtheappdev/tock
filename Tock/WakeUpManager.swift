//
//  WakeUpManager.swift
//  Tock
//
//  Created by Kevin Turner on 6/15/16.
//  Copyright © 2016 Kevin Turner. All rights reserved.
//


import Foundation


class WakeUpManager: NSObject {
      let userDefaults = UserDefaults.standard
    fileprivate static var queued: wakeUpTypes?
    fileprivate static  var removeQueued: wakeUpTypes?
  
    func addWakeUp(_ wakeUp: wakeUpTypes){
        var wakeUps = userDefaults.object(forKey: wakeUpsKey) as? [String]
        if wakeUps == nil {
            wakeUps =  [wakeUp.rawValue]
        } else {
            wakeUps!.append(wakeUp.rawValue)
        }
        print("adding new wakeup as \(wakeUp)")
        userDefaults.set(wakeUps as AnyObject, forKey: wakeUpsKey)
    }
    
    
    func updateWakeUps(wakeUps: [wakeUpTypes]){
        var newWakes = [String]()
        for wakeUp in wakeUps {
            newWakes.append(wakeUp.rawValue)
        }
        
        userDefaults.set(newWakes, forKey: wakeUpsKey)
    }
    
    
    func addToRemoveQueue(_ wakeUp: wakeUpTypes){
        WakeUpManager.removeQueued = wakeUp
    }

    
    
    func addToQueue(_ wakeUp: wakeUpTypes){
        WakeUpManager.queued = wakeUp
    }
    
    func commitQueue(){
        if let wakeUp = WakeUpManager.queued {
            addWakeUp(wakeUp)
            WakeUpManager.queued = nil
        }
        
    }

    
    func commitRemoveQueue(){
        if let wakeUp = WakeUpManager.removeQueued {
            removeWakeUp(wakeUp)
            WakeUpManager.removeQueued = nil
            print("wakeup types \(getWakeUpTypes())")
        }
    }
    
    
    func removeWakeUp(_ wakeup: wakeUpTypes){
        var wakeUps = getWakeUpTypes()
        let index = wakeUps?.index( of: wakeup.rawValue)
        if index != nil {
            wakeUps?.remove(at: index!)
        }
        userDefaults.set(wakeUps, forKey: wakeUpsKey)
    }
    
    func wakeUpExists(_ wakeUp: wakeUpTypes) -> Bool {
        let wakeUps = getWakeUpTypes()
        if wakeUps != nil {
            return wakeUps!.contains(wakeUp.rawValue)
        }
        
        return false
    }
    
    func getWakeUpTypes() -> [String]?{
        return userDefaults.object( forKey: wakeUpsKey) as? [String]
    }
    
    
    func getWakeUps() -> [wakeUpTypes:TockWakeUp]{
        
        var wakeUps = Dictionary<wakeUpTypes, TockWakeUp>()
        let wuTypes = getWakeUpTypes()
        if let types = wuTypes {
        for wakeType in types {
            let wakeUp = wakeUpTypes(rawValue: wakeType)!
            print("wakeUp becomes : \(wakeUp)")
            switch  wakeUp {
                case .wakeUpTypeCal:
                    let calWakeup = CalendarTockWakeUp()
                    wakeUps[.wakeUpTypeCal] = calWakeup
                    break
                case .wakeUpTypeWeather:
                    let locationString = userDefaults.object( forKey: locationKey) as! String
                    let weatherWakeup = WeatherTockWakeUp(location: locationString)
                    wakeUps[.wakeUpTypeWeather] = weatherWakeup
             
                    break
            case .wakeUpTypeTransit:
                let fromLocation = userDefaults.object(forKey: fromLocationKey) as! String
                let toLocation = userDefaults.object(forKey: toLocationKey) as! String
                let transitWakeup = TransitTockWakeUp(from: fromLocation, to: toLocation)
                wakeUps[.wakeUpTypeTransit] = transitWakeup
                break
            case .wakeUpTypeNews:
                let news = NewsTockWakeUp()
                wakeUps[.wakeUpTypeNews] = news
                break
                default:
                   break
                }
            print("Test \(wakeUp.rawValue)")
            }
        }
        
        return wakeUps
    }
    
    
}
