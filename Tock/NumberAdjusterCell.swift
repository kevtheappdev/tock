//
//  NumberAdjusterCell.swift
//  Tock
//
//  Created by Kevin Turner on 7/19/16.
//  Copyright © 2016 Kevin Turner. All rights reserved.
//

import UIKit

class NumberAdjusterCell: UITableViewCell {

    @IBOutlet weak var numberAdjuster: nuberAdjuster!
    @IBOutlet weak var titleLabel: UILabel!
    let background = UIView()
    weak var tableView: TockSettingsTableView?
  
    var row: Int {
        get {
            return numberAdjuster.tag
        }
        
        set {
            numberAdjuster.tag = newValue
        }
    }
    
    
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
        
        self.contentView.insertSubview(background, belowSubview: self.numberAdjuster)
        super.layoutSubviews()

    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        numberAdjuster.addTarget(tableView, action: #selector(TockSettingsTableView.numberChanged(_:)), for: .valueChanged)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

       
    }
    
    
    

}
