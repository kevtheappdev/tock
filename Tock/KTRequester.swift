//
//  KTRequester.swift
//  Tock
//
//  Created by Kevin Turner on 7/9/16.
//  Copyright © 2016 Kevin Turner. All rights reserved.
//

import UIKit

enum requestType {
    case summarize
    case regular
}

class KTRequester: NSObject {
    fileprivate let sessionConfig: URLSessionConfiguration = URLSessionConfiguration.default
    fileprivate let session : URLSession
 internal var delegate :  KTRequesterDelegate?
    var type: requestType = .regular
    
    override init() {
        
        sessionConfig.httpAdditionalHeaders = ["Accept":"application/json"]
        sessionConfig.timeoutIntervalForRequest = 30.0
        sessionConfig.timeoutIntervalForResource = 60.0
        sessionConfig.httpMaximumConnectionsPerHost = 1
        self.session  = URLSession(configuration: self.sessionConfig)

    }
    
     func makeRequest(_ url: URL)
    {
        
        session.dataTask(with: url as URL, completionHandler: {(data, response, error) in
            print("completion handler called")
            if (error == nil) {
                print(data!)
                self.delegate?.requestCompleted(data!, type: .regular)
                print("request completed")
            } else {
                print("request failed")
                self.delegate?.requestFailed(error! as NSError)
                print(error!)
            }
            
        }).resume()

    
            
    }
    
    func makeRequestWithHeaders(url: URL){
        print("now making request with header")
        var mutableRequest = URLRequest(url: url)
        //let mutableRequest = NSMutableURLRequest(url: url)
        mutableRequest.setValue("37f461422f787b085251236b4b430405", forHTTPHeaderField: "X-AYLIEN-TextAPI-Application-Key")
        mutableRequest.setValue("61d17ec0", forHTTPHeaderField: "X-AYLIEN-TextAPI-Application-ID")
        mutableRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        session.dataTask(with: mutableRequest, completionHandler: {(data, response, error) in
            
            if error == nil {
                self.delegate?.requestCompleted(data!, type: .summarize)
            } else {
                self.delegate?.requestFailed(error! as NSError)
            }
            
        }).resume()
    }

}
