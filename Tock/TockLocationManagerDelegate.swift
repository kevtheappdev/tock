//
//  TockLocationManagerDelegate.swift
//  Tock
//
//  Created by Kevin Turner on 6/15/16.
//  Copyright © 2016 Kevin Turner. All rights reserved.
//

import Foundation


protocol  TockLocationManagerDelegate {
    func locationFound(_ location: Location, inCity: String?)
    func locationFailed(_ error:NSError)
    func latlongFailed()

}
