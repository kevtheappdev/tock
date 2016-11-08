//
//  RightSlideTransition.swift
//  Tock
//
//  Created by Kevin Turner on 6/15/16.
//  Copyright © 2016 Kevin Turner. All rights reserved.
//

import UIKit

class RightSlideTransition: NSObject, UIViewControllerAnimatedTransitioning
{
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView
        
        
        
        let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        
        let fromView = fromVC.view
        let toView = toVC.view
       
        let finalFrame = fromView?.frame
        
        toView?.frame = CGRect(x: (finalFrame?.size.width)!, y: 0, width: (finalFrame?.size.width)!, height: (finalFrame?.size.height)!)
        containerView.addSubview(toView!)
        
        UIView.animate( withDuration: transitionDuration(using: transitionContext), animations: {() in
            fromView?.frame = CGRect(x: (finalFrame?.origin.x)! - (finalFrame?.size.width)!, y: (finalFrame?.origin.y)!, width: (finalFrame?.size.width)!, height: (finalFrame?.size.height)!)
            toView?.frame = finalFrame!
            }, completion: {(done) in
                if done {
                    transitionContext.completeTransition(true)
                }
        })
        
        
        
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }
}
