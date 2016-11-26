//
//  HomeTutorialViewController.swift
//  Tock
//
//  Created by Kevin Turner on 11/25/16.
//  Copyright © 2016 Kevin Turner. All rights reserved.
//

import UIKit

class HomeTutorialViewController: UIViewController, UIViewControllerTransitioningDelegate {
let optionsTransition = OptionsTransitionDelegate()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func swipeRight(_ sender: Any) {
        self.performSegue(withIdentifier: "cont", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination
        vc.transitioningDelegate = self
    }
    
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ConfigureTransition()
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
