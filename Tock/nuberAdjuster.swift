//
//  nuberAdjuster.swift
//  Tock
//
//  Created by Kevin Turner on 7/18/16.
//  Copyright © 2016 Kevin Turner. All rights reserved.
//

import UIKit

class nuberAdjuster: UIControl {

    
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var numberLabel: UILabel!
    var count = 0
    private var minValue = 0
    private var maxValue = 10
    
   
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        print("custom view")
    }
    
    @IBAction func minusButtonPressed(_ sender: AnyObject) {
        if self.count > minValue {
            count -= 1
            self.numberLabel.text = String(count)
            self.sendActions(for: .valueChanged)
        }
    }
    
    
    @IBAction func plusButtonPressed(_ sender: AnyObject) {
        if self.count < maxValue {
            count += 1
            self.numberLabel.text = String(count)
            self.sendActions(for: .valueChanged)
        }
        
    }
    
 
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
