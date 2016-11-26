//
//  StartButton.swift
//  Tock
//
//  Created by Kevin Turner on 11/22/16.
//  Copyright © 2016 Kevin Turner. All rights reserved.
//

import UIKit

class StartButton: UIButton {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func layoutSublayers(of layer: CALayer) {
        let gradient = CAGradientLayer()
        gradient.frame = CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height)
        gradient.colors = [UIColor(red: 1, green: 0.4393680155, blue: 0.001996452746, alpha: 1).cgColor, UIColor(red: 1, green: 0.7662689211, blue: 0.3382564307, alpha: 1).cgColor]
        layer.backgroundColor = UIColor.orange.cgColor
        self.layer.addSublayer(gradient)
        
        self.layer.shadowColor = backgroundColor?.cgColor
        self.layer.masksToBounds = true
        
        
        let text = CATextLayer()
        text.frame = gradient.frame
        text.string = "Start"
        text.font = UIFont(name: "AvenirNext-Regular", size: 15)
        text.bounds = CGRect(x: 0, y: 0, width: bounds.width/2, height: bounds.height/2)
        text.fontSize = 20
     
        text.alignmentMode = kCAAlignmentCenter
        text.position = CGPoint(x: bounds.midX, y: bounds.midY-3)
        layer.addSublayer(text)
    }

}
