//
//  TodayViewController.swift
//  Tock Widget
//
//  Created by Kevin Turner on 12/15/16.
//  Copyright © 2016 Kevin Turner. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
        
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var timeLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
      

    }
    
    @IBAction func openApp(_ sender: Any) {
        let url = URL(string:"tockApp://")
        print("was tapped")
        self.extensionContext?.open(url!, completionHandler: {(successs) in
           print(successs)
        })
    }
    override func viewDidLayoutSubviews() {
        let gradient = CAGradientLayer()
        gradient.frame = self.containerView.frame
        gradient.colors = [UIColor(red: 1, green: 0.4393680155, blue: 0.001996452746, alpha: 1).cgColor, UIColor(red: 1, green: 0.7662689211, blue: 0.3382564307, alpha: 1).cgColor]
        
        self.containerView.layer.insertSublayer(gradient, below: timeLabel.layer)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        let sharedDefaults = UserDefaults(suiteName: "group.com.kevinturner.TockTodayView")
    
        let fetchedDate = sharedDefaults?.object(forKey: wakeUpTimeKey) as? Date
        if let date = fetchedDate  {
            var calendar = Calendar(identifier: .gregorian)
        
            calendar.timeZone = .current
        
            let dateComponents = calendar.dateComponents([.hour, .minute], from: date)
        
            var hour = dateComponents.hour!
            let minute = dateComponents.minute!
            var postFix = "AM"
            var minuteString = "\(minute)"
        
            if hour > 12 {
                hour = hour - 12
                postFix = "PM"
            }
            
            if minute < 10 {
                minuteString = "0" + minuteString
            }
        
            self.timeLabel.text = "\(hour):\(minuteString) " + postFix
        } else {
            self.timeLabel.text = "No Alarm Set"
        }
        
        completionHandler(NCUpdateResult.newData)
    }
    
}
