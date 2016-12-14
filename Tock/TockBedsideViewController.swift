//
//  TockBedsideViewController.swift
//  Tock
//
//  Created by Kevin Turner on 12/5/16.
//  Copyright © 2016 Kevin Turner. All rights reserved.
//

import UIKit

class TockBedsideViewController: UIViewController {

    @IBOutlet weak var timeLabel: UILabel!
    var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIScreen.main.brightness = CGFloat(0.1)
        
        self.timeLabel.text = KTUtility.getCurrentDate()
      
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(TockBedsideViewController.updateTime), userInfo: nil, repeats: true)
        
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
