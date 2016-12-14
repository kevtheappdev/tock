//
//  TockEventsManagerDelegate.swift
//  Tock
//
//  Created by Kevin Turner on 6/15/16.
//  Copyright © 2016 Kevin Turner. All rights reserved.
//

import Foundation
import EventKit

protocol TockEventsMangerDelegate {
    func calendarAccess(_ granted: Bool)
    func reminderAccess(_ granted: Bool)
}
