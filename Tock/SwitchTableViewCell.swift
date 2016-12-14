//
//  SwitchTableViewCell.swift
//  Tock
//
//  Created by Kevin Turner on 12/3/16.
//  Copyright © 2016 Kevin Turner. All rights reserved.
//

import UIKit

protocol SwitchCellDelegate : class {
    func switchChanged(tag: Int, on: Bool)
}

class SwitchTableViewCell: UITableViewCell {
    @IBOutlet weak var switchTitleLabel: UILabel!
    @IBOutlet weak var `switch`: UISwitch!
    
    let background = UIView()
    
    weak var delegate : SwitchCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
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
        
        self.contentView.insertSubview(background, belowSubview: self.switchTitleLabel)
        
        super.layoutSubviews()
    }
    
    
    
    func setName(name: String, andTag: Int, isOn: Bool){
        self.switchTitleLabel.text = name
        self.switch.tag = andTag
        self.switch.isOn = isOn
    }
    
    @IBAction func switchChanged(_ sender: Any) {
        self.delegate?.switchChanged(tag: self.switch.tag, on: self.switch.isOn)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
