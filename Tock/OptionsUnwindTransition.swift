//
//  OptionsUnwindTransition.swift
//  Tock
//
//  Created by Kevin Turner on 11/11/16.
//  Copyright © 2016 Kevin Turner. All rights reserved.
//

import UIKit

class OptionsUnwindTransition: NSObject,  UIViewControllerAnimatedTransitioning{
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning){
        let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) as? ViewController
        let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)

        
        let containerView = transitionContext.containerView
        
        let toView = toVC!.view
        let fromView = fromVC!.view
        
        
        
        UIGraphicsBeginImageContextWithOptions((fromView?.bounds.size)!, true, UIScreen.main.scale)
        let context = UIGraphicsGetCurrentContext()
        
        context!.saveGState()
    
        
        //toView?.layer.render(in: context!)
        toView?.drawHierarchy(in: toView!.bounds, afterScreenUpdates: true)
        let toSnapshot = UIGraphicsGetImageFromCurrentImageContext()
       
        context!.saveGState()

        //fromView?.drawHierarchy(in: fromView!.bounds, afterScreenUpdates: true)
        fromView?.layer.render(in: UIGraphicsGetCurrentContext()!)
        
        let fromSnapshot = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        let fromLayer = CALayer()
        fromLayer.frame = CGRect(x: 0, y: 0, width: fromSnapshot!.size.width, height: fromSnapshot!.size.height)
        fromLayer.contents = fromSnapshot!.cgImage
        
        fromLayer.contentsScale = UIScreen.main.scale
        
        
        let toLayer = CALayer()
        toLayer.frame = CGRect(x: 0, y: 0, width: toSnapshot!.size.width, height: toSnapshot!.size.height)
        toLayer.contentsScale = UIScreen.main.scale
        toLayer.contents = toSnapshot!.cgImage
        
        containerView.layer.addSublayer(toLayer)

        containerView.layer.addSublayer(fromLayer)
       
        
        let tockButton = toVC!.dropButton
        
        let frame = fromView?.convert((tockButton?.frame)!, to: containerView)
        
        print("frame d \(frame)")
        
        let maskLayer = CAShapeLayer()
        maskLayer.frame = frame!
        fromLayer.mask = maskLayer
        
        let startShape = UIBezierPath(roundedRect: CGRect(x: -950, y: -950, width: 2000, height: 2000), cornerRadius: 1000).cgPath
        
         let endShape = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 120, height: 120), cornerRadius: 50).cgPath
        
        maskLayer.path = startShape
        
        let animation = CABasicAnimation(keyPath: "path")
        animation.toValue = endShape
        animation.duration = self.transitionDuration(using: transitionContext)
        
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
        animation.fillMode = kCAFillModeBoth
        animation.isRemovedOnCompletion = false
        
        CATransaction.begin()
        
        
        CATransaction.setCompletionBlock({()in
            toView?.drawHierarchy(in: toView!.bounds, afterScreenUpdates: false)
           fromView?.removeFromSuperview()
            fromLayer.removeFromSuperlayer()
             toLayer.removeFromSuperlayer()
            containerView.addSubview(toView!)
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
