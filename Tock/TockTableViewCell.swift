//
//  TockTableViewCell.swift
//  Tock
//
//  Created by Kevin Turner on 7/13/16.
//  Copyright © 2016 Kevin Turner. All rights reserved.
//

import UIKit


class TockTableViewCell: UITableViewCell {
    var tockWakeUpType: wakeUpTypes!
    @IBOutlet weak var tockItemImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    let background = UIView()


    func setCellType(_ type: wakeUpTypes){
        self.tockWakeUpType = type
        
        self.tockItemImage.image = imageForType(type)
        self.titleLabel.text = nameForType(type)
        self.descriptionLabel.text =  self.descriptionForType(type)
        
    }
    
    
    func imageForType(_ type: wakeUpTypes) -> UIImage
    {
        switch type {
        case .wakeUpTypeCal:
            return UIImage(named: "calendar.png")!
        case .wakeUpTypeWeather:
            return UIImage(named: "sun.png")!
        case .wakeUpTypeTransit:
            return UIImage(named: "compass")!
        case .wakeUpTypeNews:
            return UIImage(named: "newspaper")!
        case .wakeUpTypeReminder:
            return UIImage(named: "list-numbered.png")!
        }
    }
    
    
    func nameForType(_ type: wakeUpTypes) -> String
    {
        switch  type {
        case .wakeUpTypeCal:
            return "Calendar"
        case .wakeUpTypeWeather:
            return "Weather"
        case .wakeUpTypeNews:
            return "News"
        case .wakeUpTypeTransit:
            return "Transit Times"
        case .wakeUpTypeReminder:
            return "Reminders"
        }
    }
    
    
    func descriptionForType(_ type: wakeUpTypes) -> String
    {
        switch type {
        case .wakeUpTypeWeather:
            return "A quick summary of the day's weather. Includes, temperature and condition for you current location"
        case .wakeUpTypeCal:
            return "Get a heads up on the day's events. Reads to you how many events are ahead of you and what each of those are"
        case .wakeUpTypeTransit:
            return "Hear how long it'll take to get to work or school"
        case .wakeUpTypeNews:
            return "Have the latest headlines from your favorite sources read to you"
        case .wakeUpTypeReminder:
            return "A reading of your reminders"
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
        
        self.contentView.insertSubview(background, belowSubview: self.tockItemImage)
         super.layoutSubviews()
      
    }
    
    override func layoutIfNeeded() { 
        self.descriptionLabel.preferredMaxLayoutWidth = self.frame.size.width - 150
    }
    

    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
