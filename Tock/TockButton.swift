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
    
    override init(frame: CGRect) {
        super.init(frame: CGRect(x: frame.origin.x, y: frame.origin.y, width: 80, height: 80))
       
    }
    
 
    
     func layoutSublayersOfLayer(layer: CALayer) {
        let gradient = CAGradientLayer()
        
        gradient.colors = [UIColor(red: 1, green: 0.4393680155, blue: 0.001996452746, alpha: 1).cgColor, UIColor(red: 1, green: 0.7662689211, blue: 0.3382564307, alpha: 1).cgColor]
        layer.backgroundColor = UIColor.clear.cgColor
        self.layer.insertSublayer(gradient, below: layer)
        layer.cornerRadius = 40
        self.layer.shadowColor = backgroundColor?.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 10
        

    }
  
    
    func displayImage(){
        self.setImage(UIImage(named: "equalizer2.png"), for:[])
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    
}
