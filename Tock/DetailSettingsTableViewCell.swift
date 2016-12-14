//
//  DetailSettingsTableViewCell.swift
//  Tock
//
//  Created by Kevin Turner on 12/2/16.
//  Copyright © 2016 Kevin Turner. All rights reserved.
//

import UIKit

class DetailSettingsTableViewCell: UITableViewCell {
    @IBOutlet weak var configLabel: UILabel!
    @IBOutlet weak var checkMark: UIImageView!
    
    let background = UIView()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.checkMark.isHidden = true
    }
    
    func check(enabled: Bool){
        self.checkMark.isHidden = !enabled
    }
    
    func setLabel(with contents: String){
        self.configLabel.text = contents
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
        
        self.contentView.insertSubview(background, belowSubview: self.configLabel)
        
        super.layoutSubviews()
    }


    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
