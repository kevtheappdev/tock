//
//  OptionsTransition.swift
//  Tock
//
//  Created by Kevin Turner on 5/28/16.
//  Copyright © 2016 Kevin Turner. All rights reserved.
//

import UIKit

class OptionsTransition: NSObject, UIViewControllerAnimatedTransitioning
{
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning)
    {
        let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) as? ViewController
        
        let containerView = transitionContext.containerView
        
        
        
        
        let toView = toVC!.view
        let fromView = fromVC!.view
        
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
        
        
        
        
        containerView.layer.addSublayer(fromLayer)
        containerView.layer.addSublayer(toLayer)
        
        
        
        let tockButton = fromVC!.dropButton
        
        let frame = fromView?.convert((tockButton?.frame)!, to: containerView)
        print("frame: \(frame) ")
        let maskLayer = CAShapeLayer()
         maskLayer.frame = frame!
        maskLayer.cornerRadius = (frame?.size.width)!/2
        toLayer.mask = maskLayer
        
        
        let startShape = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 100, height: 100), cornerRadius: 50).cgPath
        
        let endShape = UIBezierPath(roundedRect: CGRect(x: -950, y: -950, width: 2000, height: 2000), cornerRadius: 1000).cgPath
        
        maskLayer.path = startShape
        
        
        let animation = CABasicAnimation(keyPath: "path")
        animation.toValue = endShape
        animation.duration = self.transitionDuration(using: transitionContext)
        
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
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return (((19+50)/100)*420)/420
    }
}
