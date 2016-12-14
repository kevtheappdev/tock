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
    let baseURL = "https://maps.googleapis.com/maps/api/distancematrix/json?key=AIzaSyDwj8M44iY-KPXw_bEILgnSr6gRs_ifZRk&departure_time=now"
    var duration:String!
    
   init(from: String, to: String) {
        self.from = from
        self.to = to
        super.init(name: "Transit")
    }
    
    
    override func fetchData() {
        requester.delegate = self
        let url = baseURL + "&origins=place_id:\(from)&destinations=place_id:\(to)"
        print("request being made \(url)")
        requester.makeRequest(URL(string: url)!)
    }
    
    func requestFailed(_ error: NSError) {
        print("The request did not go well, error:\(error)")
        print("error code is \(error.code)")
        self.delegate?.finishedDataFetch()
    }
    
    func requestCompleted(_ data: Data, type: requestType) {
        let json = JSON(data: data)
        processJSON(json)
        self.delegate?.finishedDataFetch()

    }
    

    
    func processJSON(_ json: JSON){
        if let duration = json["rows"][0]["elements"][0]["duration_in_traffic"]["text"].string {
            print("parsing was success \(duration)")
            self.duration = duration
            self.fetchSuccess = true
        } else {
            print("problem parsing data \(json)")
        }
    }
    
    override func stringsToVerbalize() -> [String] {
        if self.fetchSuccess {
            return ["It will take \(duration!) to get to work"]
        } else {
            return ["Transit Information not availible"]
        }
    }
}
