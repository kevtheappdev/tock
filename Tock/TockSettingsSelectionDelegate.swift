//
//  TockSettingsSelectionDelegate.swift
//  Tock
//
//  Created by Kevin Turner on 7/16/16.
//  Copyright © 2016 Kevin Turner. All rights reserved.
//

import Foundation

protocol TockSettingsSelectionDelegate {
    func buttonEnabled(_ enabled: Bool)
    func presentLocationPicker()
}
