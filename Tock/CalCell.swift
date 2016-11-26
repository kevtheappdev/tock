//
//  CalCell.swift
//  Pods
//
//  Created by Kevin Turner on 11/23/16.
//
//

import UIKit

class CalCell: UITableViewCell {

    @IBOutlet weak var mainLabel: UILabel!
     let background = UIView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setWakeUp(wakeUp: TockWakeUp, type: wakeUpTypes, index: Int){
        if type == .wakeUpTypeCal {
            let cal = wakeUp as! CalendarTockWakeUp
            mainLabel.text = cal.events[index].title
        } else if type == .wakeUpTypeTransit {
            let transit = wakeUp as! TransitTockWakeUp
            mainLabel.text = transit.duration
        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
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
        
        self.contentView.insertSubview(background, belowSubview: self.mainLabel)
        
        super.layoutSubviews()
    }

}
