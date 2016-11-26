//
//  OptionsTransitionDelegate.swift
//  Tock
//
//  Created by Kevin Turner on 6/6/16.
//  Copyright © 2016 Kevin Turner. All rights reserved.
//

import UIKit

class OptionsTransitionDelegate: NSObject, UIViewControllerTransitioningDelegate {

    
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        print("options animation called")
        return OptionsTransition()
    }
    
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return OptionsUnwindTransition()
    }
}
