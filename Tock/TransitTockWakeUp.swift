//
//  TransitTockWakeUp.swift
//  Tock
//
//  Created by Kevin Turner on 7/14/16.
//  Copyright © 2016 Kevin Turner. All rights reserved.
//

import Foundation
import SwiftyJSON

class TransitTockWakeUp: TockWakeUp, KTRequesterDelegate {
    let requester = KTRequester()
    var from: String
    var to: String
    let baseURL = "https://maps.googleapis.com/maps/api/directions/json?outputFormat=json&key=AIzaSyAPZiEm5kXEsmkWYvc2WeP-q1QuwvHGEuE"
    var duration:String!
    
   init(from: String, to: String) {
        self.from = from
        self.to = to
        super.init(name: "Transit")
    }
    
    
    override func fetchData() {
        requester.delegate = self
        let url = baseURL + "&origin=place_id:\(from)&destination=place_id:\(to)"
        requester.makeRequest(URL(string: url)!)
    }
    
    func requestFailed(_ error: NSError) {
        print("The request did not go well, error:\(error)")
    }
    
    func requestCompleted(_ data: Data, type: requestType) {
        let json = JSON(data: data)
        processJSON(json)
        self.delegate?.finishedDataFetch()

    }
    
    
    func processJSON(_ json: JSON){
        if let status = json["status"].string {
            if status == "OK" {
                let route = json["routes"].array?[0]
                let leg = route?["legs"].array?[0]
                let duration = leg?["duration"].dictionary?["text"]?.string
                self.duration = duration
                print("duration: \(duration)")
                
            }
        }

    }
    
    override func stringsToVerbalize() -> [String] {
        return ["It will take \(duration!) to get to work"]
    }
}
