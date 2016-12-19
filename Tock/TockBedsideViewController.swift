//
//  TockBedsideViewController.swift
//  Tock
//
//  Created by Kevin Turner on 12/5/16.
//  Copyright © 2016 Kevin Turner. All rights reserved.
//

import UIKit

class TockBedsideViewController: UIViewController {


    @IBOutlet weak var wakeUpTime: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    var timer: Timer!
    let pastBrightness = UIScreen.main.brightness
    
    override func viewDidLoad() {
        super.viewDidLoad()

        UIScreen.main.brightness = CGFloat(0.1)
        
        self.timeLabel.text = KTUtility.getCurrentDate()
      
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(TockBedsideViewController.updateTime), userInfo: nil, repeats: true)
        
        let wakeDate = KTUtility.getDate()
        
        var cal = Calendar(identifier: .gregorian)
        cal.timeZone = .current
        
        let wakeComponents = cal.dateComponents([.hour, .minute], from: wakeDate)
        
        var hours = wakeComponents.hour!
        var postFix = "AM"
        let minuts = wakeComponents.minute!
        var minuteString = "\(minuts)"
        
        if minuts < 10 {
            minuteString = "0" + minuteString
        }
        
        if hours > 12 {
            hours = hours - 12
            postFix = "PM"
        }
        
        
        
        self.wakeUpTime.text = "\(hours):\(minuteString) \(postFix) Alarm"
        
        
    }
    
    @IBOutlet var dissmissView: UITapGestureRecognizer!
    func updateTime(){
        self.timeLabel.text = KTUtility.getCurrentDate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dissmissView(_ sender: Any) {
        self.removeFromParentViewController()
        UIScreen.main.brightness = self.pastBrightness
        self.view.removeFromSuperview()
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
