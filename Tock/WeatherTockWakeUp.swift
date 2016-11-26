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
    var apiURlString = "http://api.openweathermap.org/data/2.5/weather?appid=e5c054908fafb88214c73831ed35724b&units=imperial&"
    var apiURL: URL!
    let requester = KTRequester()
    var temp: Int!
    var name: String!
    var condition: String!
    var requestSuccessful = false
    
    
    init(location: String) {
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
        requestSuccessful = true
        let json = JSON(data: data)
        processJSON(json)
        self.delegate?.finishedDataFetch()
    }
    
    
    
    func requestFailed(_ error: NSError) {
        print("request failed to get weather")
        print(error)
    }
    
    func processJSON(_ json: JSON) {
        if let weatherArr = json["weather"].array {
            if let weather = weatherArr[0].dictionary {
                if let description = weather["description"]?.string {
                    condition = description
                }
            }
        }
        
        if let main = json["main"].dictionary {
            if let temp = main["temp"]?.int {
                self.temp = temp
            }
            
            if let name = json["name"].string{
                self.name = name
            }
        }
        
        
    }
    
    
    override func stringsToVerbalize() -> [String] {
        if requestSuccessful {
            return ["It is \(temp!) degrees in \(name!) with \(condition!)"]
        } else {
            return ["We could not retrieve weather information at this time, I'm hoping the weather is lovely"]
        }
    }
 
    
}
