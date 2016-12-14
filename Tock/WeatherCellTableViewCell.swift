
//
//  WeatherCellTableViewCell.swift
//  Tock
//
//  Created by Kevin Turner on 11/22/16.
//  Copyright © 2016 Kevin Turner. All rights reserved.
//

import UIKit

class WeatherCellTableViewCell: UITableViewCell {

    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var weatherConditionLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    let background = UIView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        weatherImage.image = #imageLiteral(resourceName: "10d.png")
        
        
    }
    
    func setWakeUp(wakeUp: TockWakeUp){
        let weatherWakup = wakeUp as! WeatherTockWakeUp
        if weatherWakup.fetchSuccess {
            self.weatherConditionLabel.text = weatherWakup.condition
                self.tempLabel.text = "\(weatherWakup.temp!)"
        self.locationLabel.text = UserDefaults.standard.object(forKey: locationStringKey) as? String
        } else {
            self.locationLabel.text = weatherWakup.failedString
        }
        
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
        
        self.contentView.insertSubview(background, belowSubview: self.tempLabel)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
