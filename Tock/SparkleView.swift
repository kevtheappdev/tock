//
//  SparkleView.swift
//  Tock
//
//  Created by Kevin Turner on 5/21/16.
//  Copyright © 2016 Kevin Turner. All rights reserved.
//

import UIKit

class SparkleView: UIView
{
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    func setup(){
        print("setting up emiter")
        setupLayer()
        let cell = setupCell()
        let emitter = self.layer as! CAEmitterLayer
        print(emitter)
        emitter.emitterCells = [cell]
    }
    
    
    func setupLayer()
    {
        let emitterLayer:CAEmitterLayer = self.layer as! CAEmitterLayer
        
        emitterLayer.seed = UInt32(Date().timeIntervalSince1970)
        emitterLayer.renderMode = kCAEmitterLayerAdditive
        emitterLayer.drawsAsynchronously = true
       
        let screenSize = UIScreen.main.bounds.size
        
        emitterLayer.emitterPosition = CGPoint(x: (screenSize.width)/2, y: frame.size.height/2)
    }
    
    
    func setupCell() -> CAEmitterCell{
        let emitterCell = CAEmitterCell()
        
        emitterCell.contents = UIImage(named: "emit")?.cgImage
        
        emitterCell.velocity = 10.0
        emitterCell.velocityRange = 500.0
        
        emitterCell.color = UIColor.black.cgColor
        emitterCell.redRange = 1.0
        emitterCell.greenRange = 0.2
        
        emitterCell.blueRange = 1.0
        emitterCell.alphaRange = 0.0
        emitterCell.redSpeed = 0.0
        emitterCell.greenSpeed = 0.0
        emitterCell.blueSpeed = 0.0
        emitterCell.alphaSpeed = 0.5
        
       
        emitterCell.spin = 2
        emitterCell.spinRange = 4
        emitterCell.emissionRange = CGFloat(M_PI_4)
        
        emitterCell.lifetime = 1.0
        emitterCell.birthRate = 50.0
        emitterCell.xAcceleration = 80.0
        emitterCell.yAcceleration = 100.0
        
        
        return emitterCell
        
    }
    
    
    override class var layerClass: AnyClass{
        return CAEmitterLayer.self
    }
    
    
    required init?(coder aDecoder: NSCoder) {
         super.init(coder: aDecoder)
        setup()
    }
}
