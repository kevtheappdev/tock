//
//  ViewController.swift
//  Tock
//
//  Created by Kevin Turner on 5/21/16.
//  Copyright © 2016 Kevin Turner. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    
    var animator: UIDynamicAnimator!
    var gravity: UIGravityBehavior!
    var floor: UICollisionBehavior!
    var dropButton: TockButton!
    let optionsTransitionDelegate = OptionsTransitionDelegate()
    let popTransitionsDelegate = PopTransitionDelegate()
    let defaults = UserDefaults.standard
    
   
    @IBOutlet weak var timePicker: TockTimePicker!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var floorView: UIView!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("loaded")
        
    
//        for family: String in UIFont.familyNames {
//            print("\(family)")
//            for name: String in UIFont.fontNames(forFamilyName: family) {
//                print("==\(name)")
//            }
//        }
//        
        
        let screenSize = UIScreen.main.bounds
       
//        let pocket = PocketTockWakeUp(name: "pocket")
//        pocket.fetchData()
//        print(pocket.stringsToVerbalize())
        
//        
//        Twitter.sharedInstance().logIn(completion: {(session, error) in
//            if session != nil {
//                print("User has been logged in")
//            } else {
//                print("There was an error \(error)")
//            }
//        })
        
//        let twitter = TwitterTockWakeUp(name: "Twitter")
//        twitter.fetchData()
//        
//        
//        let news = NewsTockWakeUp(name: "news")
//        news.fetchData()
        
//        
//        let transit = TransitTockWakeUp(name: "transit", from: "ChIJf1PYVtbRQIYRcXIqeb6Be70", to: "ChIJjXhO2t3PQIYRju8QMiDsQNQ")
//        transit.fetchData()
//        print("strings; \(transit.stringsToVerbalize())")
//
       dropButton = TockButton(frame: CGRect(x: (screenSize.size.width-80)/2, y: (screenSize.size.height-80)/2, width: 0, height: 0))
        dropButton.layer.cornerRadius = 40
        dropButton.backgroundColor = UIColor(red: 1, green: 0.4393680155, blue: 0.001996452746, alpha: 1)
        dropButton.addTarget(self, action: #selector(buttonTapped), for: UIControlEvents.touchDown)
        view.addSubview(dropButton)
        
        startButton.alpha = 0.0
        
        startButton.backgroundColor = UIColor(red: 1, green: 0.4393680155, blue: 0.001996452746, alpha: 1)        
        startButton.layer.shadowOpacity = 1
        startButton.layer.shadowRadius = 10
        startButton.layer.cornerRadius = 15
        
        
        timePicker.alpha = 0.0
        
      
        
    }
    
    
    @objc func buttonTapped(){
        self.performSegue( withIdentifier: "settings", sender: self)
        
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        
        
        if !KTUtility.onboardComplete(){
            print("Onboard the user")
            self.performSegue( withIdentifier: "onboard", sender: self)
        } else {
            animateButton()
            tockButton()
            animateTimeLabel()
            timePicker.setTime()
        }
        
 
    }
    

    
    func animateButton(){
        UIView.animate( withDuration: 2.0, animations: {() in
           self.startButton.alpha = 1.0
        })
    }
    
    
    
    func animateTimeLabel(){
        
        UIView.animate(withDuration: 2.0, animations: {() in
            self.timePicker.alpha = 1.0
        })
        
    
    }
    
    
    func tockButton(){
        let floorEdge = CGPoint(x: floorView.frame.size.width + floorView.frame.origin.x, y: floorView.frame.origin.y)
        
        animator = UIDynamicAnimator(referenceView: self.view)
        gravity = UIGravityBehavior(items: [dropButton])
        floor = UICollisionBehavior(items: [dropButton])
        floor.addBoundary(withIdentifier: "floor" as NSCopying, from: floorView.frame.origin, to: floorEdge)
        
        
        animator.addBehavior(floor)
        animator.addBehavior(gravity)
        
        dropButton.displayImage()
    }

    @IBAction func doubleTapped(_ sender: AnyObject) {
        
        self.performSegue( withIdentifier: "timeset", sender: self)
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
  
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("segue triggerred")
        if segue.identifier! == "timeset" || segue.identifier! == "alarm"{
          print("time set")
          let toVC = segue.destination
          toVC.transitioningDelegate = popTransitionsDelegate
            
        } else {
        
             let toVC = segue.destination
             toVC.transitioningDelegate = optionsTransitionDelegate
         
        
        }

    }
    
    
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }


}

