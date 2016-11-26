//
//  UnwindConfigureTransition.swift
//  Tock
//
//  Created by Kevin Turner on 11/21/16.
//  Copyright © 2016 Kevin Turner. All rights reserved.
//

import UIKit

class UnwindConfigureTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        
      
        let toView = toVC.view!
        let fromView = fromVC.view!
        
        containerView.insertSubview(toView, belowSubview: fromView)
        
        
        let initScale = CGAffineTransform(scaleX: 0.5, y: 0.5)
        
        toView.transform = initScale
      
        
        let screenWidth = UIScreen.main.bounds.width
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {() in
            toView.transform = CGAffineTransform.identity
        fromView.frame = CGRect(x: screenWidth, y: 0, width: fromView.bounds.width, height: fromView.bounds.height)
            
            
        }, completion: {(done) in
            transitionContext.completeTransition(done)
        } )
        
        
        
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.3
    }

}
