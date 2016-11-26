//
//  UpgradeViewController.swift
//  Tock
//
//  Created by Kevin Turner on 11/25/16.
//  Copyright © 2016 Kevin Turner. All rights reserved.
//

import UIKit
import StoreKit

class UpgradeViewController: UIViewController {

    @IBOutlet weak var wakeUpLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func noThanks(_ sender: Any) {
    }
    @IBAction func buyUnlimited(_ sender: Any) {
    }

    @IBAction func restorePurchase(_ sender: Any) {
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
