//
//  NewModal.swift
//  Tock
//
//  Created by Kevin Turner on 7/4/16.
//  Copyright © 2016 Kevin Turner. All rights reserved.
//

import UIKit

class NewModal: NSObject, UIViewControllerAnimatedTransitioning
{
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning)
    {
        let containerView = transitionContext.containerView
        let fromVC = transitionContext.viewController( forKey: UITransitionContextViewControllerKey.from)
        let toVC = transitionContext.viewController( forKey: UITransitionContextViewControllerKey.to)
        
        let toView = toVC?.view
        let fromView = fromVC?.view
        
        
        let screenHeight  = UIScreen.main.bounds.height
        
        toView?.frame = CGRect(x: 0, y: screenHeight, width: (toView?.bounds.width)!, height: (toView?.bounds.height)!)
        containerView.addSubview(toView!)
        
        
        let scaled = CGAffineTransform(scaleX: 0.75, y: 0.75)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {() in
           fromView?.transform = scaled
            toView?.frame  = CGRect(x: 0, y: 0, width: (toView?.bounds.width)!, height: (toView?.bounds.height)!)
            }, completion: {(done) in
                transitionContext.completeTransition(done)
        })
    }
    
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval
    {
        return 0.3
        
    }
}
