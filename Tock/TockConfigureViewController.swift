//
//  TockConfigureViewController.swift
//  Tock
//
//  Created by Kevin Turner on 7/15/16.
//  Copyright © 2016 Kevin Turner. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces

class TockConfigureViewController: UIViewController, TockSettingsSelectionDelegate {


    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var titleLabe: UILabel!
    @IBOutlet weak var tableView: TockSettingsTableView!
    var fromVC: ServiceSelectorViewController?
    var configType: wakeUpTypes!
    let wuManager = WakeUpManager()
    var hasAdded = false
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let  userDefaults = UserDefaults.standard
        self.tableView.currentLocation = defaults.object(forKey: locationStringKey) as? String
        tableView.wakeupType = configType
        self.titleLabe.text = configType.rawValue
        self.addButton.isEnabled = false
        self.addButton.alpha = 0.5
        tableView.selectionDelegate = self
        
        if wuManager.wakeUpExists(configType) {
             self.addButton.setTitle("Remove", for: [])
            self.hasAdded = true
            self.addButton.isEnabled = true
            self.addButton.alpha = 1
        }
        
        
        let gradient = CAGradientLayer()
        gradient.frame = view.frame
        gradient.colors = [UIColor(red: 1, green: 0.4393680155, blue: 0.001996452746, alpha: 1).cgColor, UIColor(red: 1, green:        0.7662689211, blue: 0.3382564307, alpha: 1).cgColor]
        
        view.layer.insertSublayer(gradient, below: self.tableView.layer)
        
        var myNews_types = Array<newsTypes>()
        
        let myNews = userDefaults.value(forKey: newsSourcesKey) as? [String]
        if let news = myNews {
            for n in news {
                myNews_types.append(newsTypes(rawValue: n)!)
            }
        }
        
        print("my news types: \(myNews_types)")
        
        self.tableView.myNews = myNews_types
       

    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()
    }
    func buttonEnabled(_ enabled: Bool) {
        self.addButton.isEnabled = enabled
        if enabled {
            DispatchQueue.main.async(execute: {() in
               self.addButton.alpha = 1
            })
    
        } else {
         DispatchQueue.main.async(execute: {() in
                self.addButton.alpha = 0.5
            })
        }
    }
    
    func presentLocationPicker() {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = self.tableView
        self.present(autocompleteController, animated: true, completion: nil)

    }
    
    
    
    
    @IBAction func backButtonPressed(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
  
    @IBAction func addButtonPressed(_ sender: AnyObject) {
        if !hasAdded {
            wuManager.commitQueue()
            fromVC?.actionOccured(withAction: actionTypes.added, wakeUpType: self.configType)
        } else {
            wuManager.removeWakeUp(self.configType)
            fromVC?.actionOccured(withAction: actionTypes.removed, wakeUpType: self.configType)
        }
        
        
        self.dismiss(animated: true, completion: nil)
    }
}
