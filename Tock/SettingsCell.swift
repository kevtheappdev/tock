//
//  SettingsCell.swift
//  Tock
//
//  Created by Kevin Turner on 7/15/16.
//  Copyright © 2016 Kevin Turner. All rights reserved.
//

import UIKit

class SettingsCell: UITableViewCell {
    
    @IBOutlet weak var aContainerView: UIView!
    @IBOutlet weak var accessoryViewWidth: NSLayoutConstraint!
    @IBOutlet weak var rightConstraint: NSLayoutConstraint!
    @IBOutlet weak var leftConstraint: NSLayoutConstraint!
    @IBOutlet weak var settingImage: UIImageView!
    @IBOutlet weak var settingsLabel: UILabel!
    var leftOffsetvalue = -66
    
    let background = UIView()
    var settingType:settingsTypes!
    
    var settingName: String {
        get {
            return settingsLabel.text ?? ""
        }
        
        set {
            self.settingsLabel.text = newValue
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
        
        self.contentView.insertSubview(background, belowSubview: self.settingsLabel)
        super.layoutSubviews()

    }
    
  
    
    func setType(_ type: settingsTypes, withName name: String, andImage image: UIImage?){
        self.settingName = name
        self.settingType = type
        if let sImage = image {
            self.settingImage.image = sImage
            self.leftConstraint.constant = CGFloat(leftOffsetvalue)
        } else {
            self.leftConstraint.constant = 0
            self.settingImage.image = nil
        }
        
        
        
        let accessoryView = acccessoryForType(type)
        if accessoryView == nil {
            self.accessoryViewWidth.constant = 0
            clearSubviews()
        } else {
            let aView = accessoryView!
            aView.frame = CGRect(x: 0, y: 0, width: aContainerView.frame.size.width, height: aContainerView.frame.size.height)
            
            self.accessoryViewWidth.constant = 68
            self.aContainerView.setNeedsLayout()
            self.aContainerView.updateConstraints()
            self.aContainerView.addSubview(accessoryView!)
          
        }
    }
    
    
    func makeAViewVisible(){
        
        self.aContainerView.alpha = 1
    }
    
    func makeAViewInvisible(){
        self.aContainerView.alpha = 0
        clearSubviews()
    }
    
    
    override func prepareForReuse() {
        self.accessoryViewWidth.constant = 0
        clearSubviews()
    }
    
    
    
    func clearSubviews(){
        for view in self.aContainerView.subviews {
            view.removeFromSuperview()
        }

    }
    
    func acccessoryForType(_ type: settingsTypes) -> UIView?{
        switch type {
        case .button:
            return nil
        case .toggle:
            let swizzler = UISwitch()
            swizzler.addTarget(self, action: #selector(SettingsCell.controlMutated), for: .valueChanged)
            
            return swizzler
        case .numberAdjust:
            //let view = NSBundle.mainBundle().loadNibNamed("numberAdjuster", owner: self, options: nil)?[0] as? UIView
                      return nil
        case .checkmark:
            let image = UIImageView(image: UIImage(named: "checkmark.png"))
            image.contentMode  =  .scaleAspectFit
            return image
       
        }
    }
    
    @objc func controlMutated(){
        print("The control changed")
    }
    
    
}
