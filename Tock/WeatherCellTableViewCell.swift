
//
//  WeatherCellTableViewCell.swift
//  Tock
//
//  Created by Kevin Turner on 11/22/16.
//  Copyright © 2016 Kevin Turner. All rights reserved.
//

import UIKit

class WeatherCellTableViewCell: UITableViewCell {

    @IBOutlet weak var weatherCondition: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var weatherConditionLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    let background = UIView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.weatherCondition.text = "\u{f002}"
        
        
    }
    
    func setWakeUp(wakeUp: TockWakeUp){
        let weatherWakup = wakeUp as! WeatherTockWakeUp
        if weatherWakup.fetchSuccess {
            self.weatherConditionLabel.text = weatherWakup.condition
            self.tempLabel.text = "\(weatherWakup.temp!)°"
            self.locationLabel.text = UserDefaults.standard.object(forKey: locationStringKey) as? String
            self.weatherCondition.text = conditionIcon(forCode: weatherWakup.code)
        } else {
            self.locationLabel.text = weatherWakup.failedString
        }
        
    }
    
    
    override func layoutSubviews() {
        let contentViewFrame = self.contentView.frame
        let horInset = CGFloat(5.0)
        let verInset = CGFloat(5.0)
        let backroundFrame = CGRect(x: horInset, y: verInset, width: contentViewFrame.width - (2*horInset), height: contentViewFrame .height - (2*verInset))
        
        
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
    
    func conditionIcon(forCode code: Int) -> String{
        if code >= 200 && code < 300 {
            return "\u{f010}"
        } else if code >= 300 && code < 400 {
            return "\u{f019}"
        } else if code >= 500 && code < 505 {
            return "\u{f009}"
        } else if code >= 505 && code < 600 {
            return "\u{f018}"
        } else if code >= 600 && code < 700 {
            return "\u{f01b}"
        } else if code >= 700 && code < 800 {
            return "\u{f014}"
        } else if code == 800 {
            return "\u{f00d}"
        } else if code > 800 && code < 900 {
            return "\u{f013}"
        }
        
        return "\u{f002}"
    }

}
