//
//  TockWakeViewController.swift
//  Tock
//
//  Created by Kevin Turner on 11/30/16.
//  Copyright © 2016 Kevin Turner. All rights reserved.
//

import UIKit

class TockWakeViewController: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gradient = CAGradientLayer()
        gradient.frame = view.frame
        gradient.colors = [UIColor(red: 1, green: 0.4393680155, blue: 0.001996452746, alpha: 1).cgColor, UIColor(red: 1, green: 0.7662689211, blue: 0.3382564307, alpha: 1).cgColor]
        self.view.layer.insertSublayer(gradient, below: self.timeLabel.layer)
        
        
        self.timeLabel.text = KTUtility.getCurrentDate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func grettingNowButtonPressed(_ sender: Any) {
        let alarmVC = getParentAlarmVC()
        if alarmVC != nil {
            alarmVC?.startReading()
        }
    }
    
    func getParentAlarmVC() -> TockAlarmViewController?
    {
        if let parentVC = self.parent {
            let alarmVC = parentVC as? TockAlarmViewController
            if let alarm = alarmVC {
                return alarm
            }
        }
        
        return nil
    }

    @IBAction func snoozeButton(_ sender: Any) {
        if let alarmVC = getParentAlarmVC() {
            self.removeFromParentViewController()
            self.view.removeFromSuperview()
            alarmVC.snoozeNow()
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
