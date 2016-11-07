//
//  UnwindPopTransition.swift
//  Tock
//
//  Created by Kevin Turner on 5/25/16.
//  Copyright © 2016 Kevin Turner. All rights reserved.
//

import UIKit

class UnwindPopTransition: NSObject, UIViewControllerAnimatedTransitioning
{
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning)
    {
        
        let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
        
        let containerView = transitionContext.containerView
        
        
        
        
        let toView = toVC!.view
        let fromView = fromVC!.view
        
        fromView?.removeFromSuperview()
        
    
        
        UIGraphicsBeginImageContextWithOptions((fromView?.bounds.size)!, false, UIScreen.main.scale)
        
        
        fromView?.drawHierarchy(in: (fromView?.bounds)!, afterScreenUpdates: true)
        
        let fromSnapshot = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        print("from snap:\(fromSnapshot)")
        UIGraphicsBeginImageContextWithOptions((toView?.bounds.size)!, false, UIScreen.main.scale)
        
        
 
        toView?.drawHierarchy(in: (toView?.bounds)!, afterScreenUpdates: true)
        
        let toSnapshot = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        
        let fromLayer = CALayer()
        fromLayer.frame = CGRect(x: 0, y: 0, width: fromSnapshot!.size.width, height: fromSnapshot!.size.height)
        fromLayer.contents = fromSnapshot!.cgImage
        
        
        
        let toLayer = CALayer()
        toLayer.frame = CGRect(x: 0, y: 0, width: toSnapshot!.size.width, height: toSnapshot!.size.height)
        toLayer.contents = toSnapshot!.cgImage
        
        
        
         containerView.layer.addSublayer(toLayer)
        containerView.layer.addSublayer(fromLayer)
       
        
        
        
        let maskLayer = CAShapeLayer()
        maskLayer.bounds = CGRect(x: 0, y: 0, width: 0, height: 0)
        maskLayer.cornerRadius = maskLayer.bounds.width/2
        fromLayer.mask = maskLayer
        maskLayer.position = containerView.center
        
        let endShape = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 0, height: 0), cornerRadius: 50).cgPath
        
        let startShape = UIBezierPath(roundedRect: CGRect(x: -500, y: -500, width: 1000, height: 1000), cornerRadius: 500).cgPath
        
        maskLayer.path = startShape
        
        
        let animation = CABasicAnimation(keyPath: "path")
        animation.toValue = endShape
        animation.duration = 0.4
        
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        animation.fillMode = kCAFillModeBoth
        animation.isRemovedOnCompletion = false
        
        CATransaction.begin()
        
        
        CATransaction.setCompletionBlock({()in
            containerView.addSubview(toView!)
            toLayer.removeFromSuperlayer()
            fromLayer.removeFromSuperlayer()
            transitionContext.completeTransition(true)
        })
        
        maskLayer.add(animation, forKey: animation.keyPath)
        
        
        
        CATransaction.commit()
        
        
        
    }
    
    
 
    
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval
    {
        return 0.4
    }
}
