//
//  WeatherTockWakeUp.swift
//  Tock
//
//  Created by Kevin Turner on 6/15/16.
//  Copyright © 2016 Kevin Turner. All rights reserved.
//

import Foundation

class WeatherTockWakeUp: TockWakeUp, KTRequesterDelegate
{
    var apiURlString = "http://api.openweathermap.org/data/2.5/weather?appid=e5c054908fafb88214c73831ed35724b&units=imperial&"
    var apiURL: URL!
    let requester = KTRequester()
    var temp: Int?
    var name: String?
    var condition: String?
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
//        do {
//             // let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [String : Any]
//            let json = [:]
//            print("json fetched: \(json)")
//            processJSON(json)
//        } catch {
//            print("error was thrown")
//        }
    }
    
    
    
    func requestFailed(_ error: NSError) {
        print(error)
    }
    
    func processJSON(_ json: NSDictionary) {
 
//         let main = json["main"] as? NSDictionary
//        if main != nil {
//            print("fetched main is: \(main!["temp"]!)")
//
//             temp = main!["temp"] as? Int
//            print("fetched main in temp: \(temp)")
//            name = json["name"] as? String
//             condition = (((json["weather"] as! Array)[0]) as! Dictionary)["description"] as? String
//            
//        }
    }
    
    
    override func stringsToVerbalize() -> [String] {
        if requestSuccessful {
            return ["It is \(temp!) degrees in \(name!) with \(condition!)"]
        } else {
            return ["We could not retrieve weather information at this time, I'm hoping the weather is lovely"]
        }
    }
 
    
}
