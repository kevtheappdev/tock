//
//  TockButton.swift
//  Tock
//
//  Created by Kevin Turner on 5/21/16.
//  Copyright © 2016 Kevin Turner. All rights reserved.
//

import UIKit

class TockButton: UIButton
{
      let imageLayer = CALayer()
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: frame.origin.x, y: frame.origin.y, width: 80, height: 80))
       displayImage()
    }
    
 
    override func layoutSublayers(of layer: CALayer) {
          let gradient = CAGradientLayer()
         gradient.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        gradient.colors = [UIColor(red: 1, green: 0.4393680155, blue: 0.001996452746, alpha: 1).cgColor, UIColor(red: 1, green: 0.7662689211, blue: 0.3382564307, alpha: 1).cgColor]
        layer.backgroundColor = UIColor.orange.cgColor
        self.layer.addSublayer(gradient)
        layer.cornerRadius = 40
        self.layer.shadowColor = backgroundColor?.cgColor
        self.layer.masksToBounds = true
        
      
        imageLayer.frame = CGRect(x:0, y:0, width: 30, height: 30)
        imageLayer.position = CGPoint(x: self.bounds.midX, y: self.bounds.midY)
        
        imageLayer.contents = UIImage(named: "equalizer2.png")?.cgImage
        self.layer.addSublayer(imageLayer)
        imageLayer.isHidden = true
       
    }
    
  
    
    func displayImage(){
        self.setImage(UIImage(named: "equalizer2.png"), for:[])
        self.imageLayer.isHidden = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
}
