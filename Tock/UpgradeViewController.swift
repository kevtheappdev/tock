//
//  UpgradeViewController.swift
//  Tock
//
//  Created by Kevin Turner on 11/25/16.
//  Copyright © 2016 Kevin Turner. All rights reserved.
//

import UIKit
import StoreKit

class UpgradeViewController: UIViewController, UIViewControllerTransitioningDelegate {

    @IBOutlet weak var wakeUpLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gradient = CAGradientLayer()
        gradient.frame = view.frame
        gradient.colors = [UIColor(red: 1, green: 0.4393680155, blue: 0.001996452746, alpha: 1).cgColor, UIColor(red: 1, green: 0.7662689211, blue: 0.3382564307, alpha: 1).cgColor]
        self.view.layer.insertSublayer(gradient, below: wakeUpLabel.layer)
        let defaults = UserDefaults.standard
          defaults.setValue(true, forKey: onboardedKey)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination
        destination.transitioningDelegate = self
    }
    
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return UnwindPopTransition()
    }

}
