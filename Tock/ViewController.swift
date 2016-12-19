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
        
    
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) {(accepted, error) in
            if !accepted {
                print("Notification access denied.")
            }
        }
        
//        for family: String in UIFont.familyNames {
//            print("\(family)")
//            for name: String in UIFont.fontNames(forFamilyName: family) {
//                print("==\(name)")
//            }
//        }
//        
        
        let screenSize = UIScreen.main.bounds
       

        var buttonSize = CGFloat(120)
        print(UIScreen.main.bounds.height)
        if UIScreen.main.bounds.height == 480 {
            buttonSize = 75
        }
       dropButton = TockButton(frame: CGRect(x: (screenSize.size.width-buttonSize)/2, y: (screenSize.size.height-buttonSize)/2, width: buttonSize, height: buttonSize))
        dropButton.layer.cornerRadius = 40
        dropButton.backgroundColor = UIColor.clear
        dropButton.setBackgroundImage(UIImage(named: "tockImage"), for: .normal)
        dropButton.addTarget(self, action: #selector(buttonTapped), for: UIControlEvents.touchDown)
        view.addSubview(dropButton)
        
        startButton.alpha = 0.0
        
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(x: 0, y: 0, width: startButton.bounds.width, height: startButton.bounds.height)
        gradient.colors = [UIColor(red: 1, green: 0.4393680155, blue: 0.001996452746, alpha: 1).cgColor, UIColor(red: 1, green: 0.7662689211, blue: 0.3382564307, alpha: 1).cgColor]
        startButton.layer.addSublayer(gradient)
    
        startButton.layer.cornerRadius = 20
        
        startButton.layer.masksToBounds = true
        startButton.contentVerticalAlignment = .center
        startButton.titleLabel?.font = UIFont(name: "AvenirNext-Regular", size: 15)
        startButton.setTitleColor(UIColor.white, for: .normal)
        startButton.setTitle("Start", for: .normal)
        
        
        
        timePicker.alpha = 0.0
        
        create3DTouchShortcuts()
      
        
    }
    
    
    func create3DTouchShortcuts(){
        let startIcon = UIApplicationShortcutIcon(type: .play)
        let startButton = UIApplicationShortcutItem(type: "com.kevinturner.TockApp.start", localizedTitle: "Start", localizedSubtitle: nil, icon: startIcon, userInfo: nil)
        
        let servicesIcon = UIApplicationShortcutIcon(type: .alarm)
        let servicesButton = UIApplicationShortcutItem(type: "com.kevinturner.TockApp.services", localizedTitle: "Services", localizedSubtitle: nil, icon: servicesIcon, userInfo: nil)
        
        UIApplication.shared.shortcutItems = [startButton, servicesButton]
        
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
             tockButton()
            animateButton()
            animateTimeLabel()
            timePicker.setTime()
        }
        
 
    }
    

    
    func animateButton(){
        UIView.animate( withDuration: 3.0, animations: {() in
           self.startButton.alpha = 1.0
        })
    }
    
    
    
    func animateTimeLabel(){
        
        UIView.animate(withDuration: 3.0, animations: {() in
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

