//
//  WeatherTockWakeUp.swift
//  Tock
//
//  Created by Kevin Turner on 6/15/16.
//  Copyright © 2016 Kevin Turner. All rights reserved.
//

import Foundation
import SwiftyJSON

class WeatherTockWakeUp: TockWakeUp, KTRequesterDelegate
{
    var apiURlString = "http://api.openweathermap.org/data/2.5/weather?appid=e5c054908fafb88214c73831ed35724b&"
    var apiURL: URL!
    let requester = KTRequester()
    var temp: Int!
    var name: String!
    var condition: String!
    var code: Int!
    
      
    init(location: String) {
        let ud = UserDefaults.standard
        let unitsString = ud.string(forKey: unitsKey)
        if unitsString != nil {
            apiURlString.append("units=\(unitsString!)&")
        } else {
            apiURlString.append("units=imperial&")
        }
        apiURlString.append(location)
        print("apiUrlString: \(apiURlString)")
        super.init(name: "Weather")
        requester.delegate = self
    }
    
    override func fetchData(){
        apiURL = URL(string: apiURlString)
        requester.makeRequest(apiURL)
    }
    
    func requestCompleted(_ data: Data, type: requestType)   {
        let json = JSON(data: data)
        processJSON(json)
        self.delegate?.finishedDataFetch()
    }
    
    
    
    func requestFailed(_ error: NSError) {
        print("request failed to get weather")
        print("error code \(error.code)")
        self.delegate?.finishedDataFetch()
    }
    
    func processJSON(_ json: JSON) {
        if let weatherArr = json["weather"].array {
            if let weather = weatherArr[0].dictionary {
                if let description = weather["description"]?.string {
                    condition = description
                }
                
                if let code = weather["id"]?.int {
                    self.code = code
                }
            }
        }
        
        if let main = json["main"].dictionary {
            if let temp = main["temp"]?.int {
                self.temp = temp
            }
            
            if let name = json["name"].string {
                self.name = name
            }
            
            self.fetchSuccess = true
        }
        
        
    }
    
    
    override func stringsToVerbalize() -> [String] {
        if fetchSuccess {
            return ["It is \(temp!) degrees in \(name!) with \(condition!)"]
        } else {
            return ["We could not retrieve weather information at this time, I'm hoping the weather is lovely"]
        }
    }
 
    
}
