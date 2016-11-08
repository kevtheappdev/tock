//
//  ServicesViewController.swift
//  Tock
//
//  Created by Kevin Turner on 7/4/16.
//  Copyright © 2016 Kevin Turner. All rights reserved.
//

import UIKit

class ServicesViewController: UIViewController, UIViewControllerTransitioningDelegate
{
    @IBOutlet weak var selectServices: UIButton!
    let transitionDelegate = ModalTransitionDelegate()
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gradient = CAGradientLayer()
        gradient.frame = view.frame
        gradient.colors = [UIColor(red: 1, green: 0.4393680155, blue: 0.001996452746, alpha: 1).cgColor, UIColor(red: 1, green: 0.7662689211, blue: 0.3382564307, alpha: 1).cgColor]
        let defaults = UserDefaults.standard
        defaults.setValue(true, forKey: onboardedKey)
        view.layer.insertSublayer(gradient, below: self.selectServices.layer)
    }
    
  
    
    
    @IBAction func optOutButton(_ sender: AnyObject) {
        
        self.performSegue(withIdentifier: "home", sender: self)
    }
    
    @IBAction func selectServices(_ sender: AnyObject) {
        self.performSegue( withIdentifier: "select", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination
        
        if segue.identifier == "select" {
            destinationVC.transitioningDelegate = transitionDelegate
        } else if segue.identifier == "home" {
            let vc = destinationVC as! ViewController
            vc.modalPresentationStyle = .custom
            vc.transitioningDelegate = self
            print("Segue to home")
        }
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return UnwindPopTransition()
    }
    
   
    
 
}
