//
//  KTRequestDelegate.swift
//  Tock
//
//  Created by Kevin Turner on 7/9/16.
//  Copyright © 2016 Kevin Turner. All rights reserved.
//

import Foundation

protocol KTRequesterDelegate {
    func requestCompleted(_ data: Data, type: requestType)
    func requestFailed(_ error: NSError)
}
