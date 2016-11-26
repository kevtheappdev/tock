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
  
    
    @IBOutlet weak var home: UIImageView!
    @IBOutlet weak var work: UIImageView!
    @IBOutlet weak var news: UIImageView!
    
    @IBOutlet weak var floorView: UIView!
    @IBOutlet weak var weather: UIImageView!
    @IBOutlet weak var calendar: UIImageView!
    @IBOutlet weak var continueButton: UIButton!
    
    var animator: UIDynamicAnimator!
    var gravity: UIGravityBehavior!
    var floor: UICollisionBehavior!
      let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gradient = CAGradientLayer()
        gradient.frame = view.frame
        gradient.colors = [UIColor(red: 1, green: 0.4393680155, blue: 0.001996452746, alpha: 1).cgColor, UIColor(red: 1, green: 0.7662689211, blue: 0.3382564307, alpha: 1).cgColor]
      
        
        self.continueButton.isHidden = true
        self.continueButton.isEnabled = false
        
        defaults.setValue(true, forKey: onboardedKey)
        view.layer.insertSublayer(gradient, below: self.selectServices.layer)
        dropEffect()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let wumanager = WakeUpManager()
        let types =  wumanager.getWakeUpTypes()
        if let t = types {
            if t.count > 0 {
                self.continueButton.isHidden = false
                self.continueButton.isEnabled = true
            }
        }
        super.viewDidAppear(animated)
    }
    
    func dropEffect(){
           let floorEdge = CGPoint(x: floorView.frame.size.width + floorView.frame.origin.x, y: floorView.frame.origin.y)
        
        animator = UIDynamicAnimator(referenceView: self.view)
        gravity = UIGravityBehavior(items: [home, work, news, weather, calendar])
        floor = UICollisionBehavior(items: [home, work, news, weather, calendar])
        floor.addBoundary(withIdentifier: "floor" as NSCopying, from: floorView.frame.origin, to: floorEdge)
        
        animator.addBehavior(floor)
        animator.addBehavior(gravity)
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
