//
//  PopTransition.swift
//  Tock
//
//  Created by Kevin Turner on 5/24/16.
//  Copyright © 2016 Kevin Turner. All rights reserved.
//

import UIKit

class PopTransition: NSObject, UIViewControllerAnimatedTransitioning
{
       func animateTransition(using transitionContext: UIViewControllerContextTransitioning)
       {
           let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
           let fromVC = transitionContext.viewController( forKey: UITransitionContextViewControllerKey.from)
        
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
        
            let maskLayer = CAShapeLayer()
            maskLayer.bounds = CGRect(x: 0, y: 0, width: 100, height: 100)
            maskLayer.cornerRadius = maskLayer.bounds.width/2
            maskLayer.backgroundColor = UIColor.red.cgColor
            toLayer.mask = maskLayer
     
            maskLayer.position = containerView.center
       
        let startShape = UIBezierPath(roundedRect: CGRect(x: 0, y: 0, width: 100, height: 100), cornerRadius: 50).cgPath

        let endShape = UIBezierPath(roundedRect: CGRect(x: -450, y: -450, width: 1000, height: 1000), cornerRadius: 500).cgPath
     
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
    
    
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval
    {
        return 0.4
    }
}
