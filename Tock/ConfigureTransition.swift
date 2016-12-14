//
//  ConfigureTransition.swift
//  Tock
//
//  Created by Kevin Turner on 11/21/16.
//  Copyright © 2016 Kevin Turner. All rights reserved.
//

import UIKit

class ConfigureTransition: NSObject, UIViewControllerAnimatedTransitioning {
 
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        
        let toView = toVC.view
        let fromView = fromVC.view
        
        let screenWidth = UIScreen.main.bounds.width
        
        toView?.frame = CGRect(x: screenWidth, y: 0, width: (toView?.bounds.width)!, height: (toView?.bounds.height)!)
        containerView.addSubview(toView!)
        
        let scaled = CGAffineTransform(scaleX: 0.5, y: 0.5)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {() in
            fromView?.transform = scaled
            toView?.frame = CGRect(x: 0, y: 0, width: (toView?.bounds.width)!, height: (toView?.bounds.height)!)
            
        }, completion: {(done) in
            fromView?.removeFromSuperview()
          transitionContext.completeTransition(done)
        })
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }
}
