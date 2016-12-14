//
//  NumberAdjusterCell.swift
//  Tock
//
//  Created by Kevin Turner on 7/19/16.
//  Copyright © 2016 Kevin Turner. All rights reserved.
//

import UIKit

class TempUnitsCell: UITableViewCell {


    @IBOutlet weak var temp: UISegmentedControl!
    @IBOutlet weak var titleLabel: UILabel!
    let background = UIView()

  

    
    func setTitle(_ title: String){
        titleLabel.text = title
    }
    
    override func layoutSubviews() {
        let contentViewFrame = self.contentView.frame
        let horInset = CGFloat(5.0)
        let verInset = CGFloat(5.0)
        let backroundFrame = CGRect(x: horInset, y: verInset, width: contentViewFrame.width - (2*horInset), height: contentViewFrame.height - (2*verInset))
        
        
        background.frame = backroundFrame
        background.layer.cornerRadius = 20
        background.backgroundColor = UIColor.white
        background.alpha = 0.3
        
        self.contentView.insertSubview(background, belowSubview: self.titleLabel)
        super.layoutSubviews()

    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        temp.addTarget(self, action: #selector(TempUnitsCell.tempUnitChanged), for: .valueChanged)
    }
    
    func tempUnitChanged(){
        let unitValue = self.temp.selectedSegmentIndex
        let defaults = UserDefaults.standard
        switch unitValue {
        case 0:
            defaults.setValue("imperial", forKey: unitsKey)
            break
        case 1:
            defaults.setValue("metric", forKey: unitsKey)
            break
        default:
            break
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    
    

}
