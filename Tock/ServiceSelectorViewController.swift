//
//  ServiceSelectorViewController.swift
//  Tock
//
//  Created by Kevin Turner on 7/4/16.
//  Copyright © 2016 Kevin Turner. All rights reserved.
//

import UIKit




class ServiceSelectorViewController: UIViewController, TockTableViewSelectionDelegate, UIViewControllerTransitioningDelegate
{
    
    @IBOutlet weak var settingsButton: UIButton!
    var configType: wakeUpTypes!
    @IBOutlet weak var tableView: TockTableView!
    @IBOutlet weak var statusLabel: UILabel!
    var displaySettings = true

   var allWakeUps = [wakeUpTypes.wakeUpTypeCal, wakeUpTypes.wakeUpTypeWeather, wakeUpTypes.wakeUpTypeTransit, wakeUpTypes.wakeUpTypeNews, wakeUpTypes.wakeUpTypeReminder]
    var addedWakeUps = Array<wakeUpTypes>()
    let wuManager = WakeUpManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.settingsButton.isEnabled = displaySettings
        self.settingsButton.isHidden = !displaySettings
     
        
        let gradient = CAGradientLayer()
        gradient.frame = view.frame
        gradient.colors = [UIColor(red: 1, green: 0.4393680155, blue: 0.001996452746, alpha: 1).cgColor, UIColor(red: 1, green: 0.7662689211, blue: 0.3382564307, alpha: 1).cgColor]
        
        view.layer.insertSublayer(gradient, below: self.tableView.layer)
        
        
        tableView.setTockDataSourceTypes(allWakeUps)
        tableView.selectionDelegate = self
        
        
        let wakeUps = wuManager.getWakeUpTypes()
        if let woke = wakeUps{
            for wake in woke {
                addedNewWakeUp(wakeUpTypes(rawValue: wake)!)
            }
        }
        
        
        
        let longPress = UILongPressGestureRecognizer(target: self.tableView, action: #selector(TockTableView.longPressRecognized))
        self.tableView.addGestureRecognizer(longPress)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }

    @IBAction func doneButtonPressed(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @objc func loggedOn(){
        print("User has been logged on to pocket")
        
    }
    
    func typeSelected(_ type: wakeUpTypes) {
       self.configType = type
        
        DispatchQueue.main.async(execute: {() in
        
          self.performSegue(withIdentifier: "settings", sender: self)
        })
        
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "settings" {
            let vc = segue.destination as! TockConfigureViewController
            vc.configType = self.configType
            vc.fromVC = self
            vc.transitioningDelegate = self
        } else {
            let vc = segue.destination
            vc.transitioningDelegate = self
        }
    }
    
    func actionOccured(withAction action: actionTypes, wakeUpType: wakeUpTypes){
        self.statusLabel.text = action.rawValue
        Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(ServiceSelectorViewController.statuslabelFade), userInfo: nil, repeats: false)
        if action == .added {
            addedNewWakeUp(wakeUpType)
        } else {
            removedWakeUp(wakeUpType)
        }
    }
    
    func removedWakeUp(_ wakeUp: wakeUpTypes){
        let index = self.addedWakeUps.index(of: wakeUp)
        if index != nil {
            self.addedWakeUps.remove(at: index!)
            self.allWakeUps.append(wakeUp)

            self.tableView.setMyWakeUps(self.addedWakeUps)
            self.tableView.setTockDataSourceTypes(self.allWakeUps)
            self.tableView.reloadData()
        }
    }
    
    
    func addedNewWakeUp(_ wakeUpType: wakeUpTypes){
        let index = self.allWakeUps.index(of: wakeUpType)
        if index != nil{
            self.addedWakeUps.append(wakeUpType)
            self.allWakeUps.remove(at: index!)
            self.tableView.setMyWakeUps(self.addedWakeUps)
            self.tableView.setTockDataSourceTypes(self.allWakeUps)
            self.tableView.reloadData()
        }
    }
    
    @objc func statuslabelFade(){
        UIView.animate(withDuration: 1.0, animations: {() in
           self.statusLabel.alpha = 0
            }, completion: {(done) in
            self.statusLabel.text = ""
            self.statusLabel.alpha = 1
        })
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {

        return ConfigureTransition()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return UnwindConfigureTransition()
    }

}
